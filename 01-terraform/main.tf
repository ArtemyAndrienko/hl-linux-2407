locals {
  ssh_key = "ubuntu:${file(var.ssh_key_pub)}"
}

resource "yandex_vpc_network" "vpc" {
  folder_id = var.folder_id
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet" {
  folder_id = var.folder_id
  v4_cidr_blocks = var.subnet_cidrs
  zone           = var.availability_zone
  name           = var.subnet_name
  network_id = yandex_vpc_network.vpc.id
}

resource "yandex_vpc_address" "hl_vm_public_ip" {
  name = "hl-vm-public-address"

  external_ipv4_address {
    zone_id = var.availability_zone
  }

  depends_on = [yandex_vpc_network.vpc]
}

resource "yandex_compute_instance" "vm_standart_2_4" {
  name        = var.vm_name
  hostname    = var.vm_name
  platform_id = var.platform_id
  zone        = var.availability_zone
  folder_id   = var.folder_id
  resources {
    cores         = var.cpu
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    nat                = var.nat
    ip_address         = var.internal_ip_address
    nat_ip_address     = var.nat_ip_address
  }

  metadata = {
    ssh-keys           = local.ssh_key
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Dependencies installed!"]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_key_priv)
    }
  }
  depends_on = [yandex_vpc_address.hl_vm_public_ip]
}


resource "local_file" "AnsibleInventory" {
  content = templatefile("terraform_tmplt/inventory.tmpl",
    {
      nginx_name    = yandex_compute_instance.vm_standart_2_4.name
      nginx_ip      = local.hl_vm_public_ip
      username      = "ubuntu",
      ssh_nginx_key = "~/.ssh/id_rsa_hl_lab"
    }
  )
  filename = "iac/inventory.ini"

  depends_on = [yandex_compute_instance.vm_standart_2_4]
}

resource "null_resource" "play_ansible" {
  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [local_file.AnsibleInventory]

  provisioner "local-exec" {
    command = "ansible-playbook iac/nginx-install.yml -i iac/inventory.ini"
  }
}


locals {
  # hl_vm_public_ip = yandex_vpc_address.hl_vm_public_ip.external_ipv4_address[0].address 
  hl_vm_public_ip = yandex_compute_instance.vm_standart_2_4.network_interface.0.nat_ip_address
}


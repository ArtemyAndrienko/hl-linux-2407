output "hl_vm_login_command" {
  value = "ssh -i ${var.ssh_key_pub} ubuntu@${local.hl_vm_public_ip}"
}

output "hl_vm_nginx_address" {
  value = "http://${local.hl_vm_public_ip}"
}

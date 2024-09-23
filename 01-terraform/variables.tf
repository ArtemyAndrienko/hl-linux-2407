variable "ssh_key_priv" {
  type        = string
  description = "Path to SSH public key directory (e.g. `/secrets`)"
  default = "~/.ssh/id_rsa_hl_lab"
}

variable "ssh_key_pub" {
  type        = string
  description = "Path to SSH public key directory (e.g. `/secrets`)"
  default = "~/.ssh/id_rsa_hl_lab.pub"
}

variable "vpc_name" {
  type = string
  description = "VPC name"
  default = "vpc01"
}

variable "create_new_vpc" {
  type = bool
  default = false
}

variable "availability_zone" {
  type = string
  default = "ru-central1-d"
  description = "zone"
}

variable "subnet_name" {
  type = string
  description = "subnet name"
  default = "hl-subnet01"
}

variable "subnet_cidrs" {
  type = list(string)
  description = "CIDRs"
  default =  ["10.10.10.0/28"]
}

## VM parameters
variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "vm-test"
}

variable "cpu" {
  description = "VM CPU cores"
  default     = 2
  type        = number
}

variable "memory" {
  description = "VM RAM GB"
  default     = 4
  type        = number
}

variable "core_fraction" {
  description = "Core fraction, default 100%"
  default     = 100
  type        = number
}

variable "disk" {
  description = "VM Disk size (GB)"
  default     = 10
  type        = number
}

variable "image_id" {
  description = "Image ID (default - Ubuntu 22 LTS)"
  default     = "fd8n6sult0bipcm75u12" # ubuntu-22-04-lts
  type        = string
}

variable "nat" {
  type    = bool
  default = true
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "internal_ip_address" {
  type    = string
  default = null
}

variable "nat_ip_address" {
  type    = string
  default = null
}

variable "disk_type" {
  description = "Disk type"
  type        = string
  default     = "network-ssd"
}

variable "ssh_key" {
  type        = string
  description = "cloud-config ssh key"
  default = ""
}
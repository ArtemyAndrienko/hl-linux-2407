variable "cloud_id" {
  description = "Cloud id where to create the sources"
  type        = string
}

variable "folder_id" {
  description = "Folder id where to create the sources"
  type        = string
}



terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.115.1"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-d" # Зона доступности по умолчанию
  #service_account_key_file = "key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

provider "null" {
  # No configuration options
}



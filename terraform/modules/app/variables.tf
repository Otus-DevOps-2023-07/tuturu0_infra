variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "subnet_id" {
  description = "Subnets for modules"
}

variable "environment" {
  description = "Prod or Stage"
  default     = "Prod"
}

variable "vm_count" {
  description = "number of vms"
  default     = 1
}

variable "db_ip" {
  description = "database ip"
}

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}


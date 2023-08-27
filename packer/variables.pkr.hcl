variable "service_account_key_file" {
    type = string
    default = "/root/key.json"
}

variable "folder_id" {
    type = string
    default = "b1g57va3f20lbki0ntum"
}

variable "source_image_family" {
    type = string
    default = "ubuntu-1604-lts"
}

variable "image_family" {
    type = string
    default = "reddit-base"
}

variable "ssh_username" {
    type = string
    default = "ubuntu"
}

variable "platform_id" {
    type = string
    default = "standard-v1"
}

variable "use_ipv4_nat" {
    type = string
    default = "true"
}

variable "zone" {
    type = string
    default = "ru-central1-a"
}


locals {
    name = "reddit-base-2-${formatdate("MM-DD-YYYY", timestamp())}"
}



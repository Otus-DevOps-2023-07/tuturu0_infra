source "yandex" "ubuntu16" {
  service_account_key_file = var.service_account_key_file
  folder_id               = var.folder_id
  source_image_family     = var.source_image_family
  image_name              = local.name
  image_family            = var.image_family
  ssh_username            = var.ssh_username
  platform_id             = var.platform_id
  use_ipv4_nat            = var.use_ipv4_nat
  zone                    = var.zone
}


build {
  sources = ["source.yandex.ubuntu16"]

  provisioner "shell" {
    name            = "reddit-full"
    script          = "./reddit-full.sh"
    execute_command = "sudo {{.Path}}"
  }

}

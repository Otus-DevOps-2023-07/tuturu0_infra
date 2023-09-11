#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
#  }
#}


terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "backend-tf"
    region                      = "ru-central1"
    key                         = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

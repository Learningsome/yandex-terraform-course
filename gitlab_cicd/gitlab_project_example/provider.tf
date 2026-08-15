# Объявление провайдера
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.178.0"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  zone = "ru-central1-a"
}

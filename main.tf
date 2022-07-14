terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.73.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

data "yandex_vpc_subnet" "docker_subnet" {
  name = "default-ru-central1-a"
}

module "swarm_cluster" {
  source        = "./modules/instance"
  vpc_subnet_id = data.yandex_vpc_subnet.docker_subnet.id
  managers      = 1
  workers       = 1
}

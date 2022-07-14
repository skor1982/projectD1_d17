data "yandex_compute_image" "d17_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "vm-manager" {
  count    = var.managers
  name     = "d17-manager-${count.index}"
  hostname = "d17-manager-${count.index}"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.d17_image.id
      size     = 10
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.ssh_credentials.user}:${file(var.ssh_credentials.pub_key)}"
  }

  scheduling_policy {
    preemptible = true
  }

}

resource "yandex_compute_instance" "vm-worker" {
  count    = var.workers
  name     = "d17-worker-${count.index}"
  hostname = "d17-worker-${count.index}"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.d17_image.id
      size     = 10
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.ssh_credentials.user}:${file(var.ssh_credentials.pub_key)}"
  }

  scheduling_policy {
    preemptible = true
  }

}

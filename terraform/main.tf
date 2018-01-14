provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_project_metadata" "default" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }
}

resource "google_compute_instance" "app" {
  machine_type = "g1-small"
  count        = 2
  name         = "reddit-app-${count.index}"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
       network       = "default"
       access_config = {
         nat_ip = "${google_compute_address.app_ip.*.address}"
       }
  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с тегом ...
  target_tags = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  description = "Allow ssh from everywhere terraform-2"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "app_ip" {
             name = "reddit-app-ip"
             count        = 2
}

# Второе задание со звездочкой terraform-1

resource "google_compute_instance_group" "reddit-app" {
  name        = "reddit-app-group"
  description = "reddit-app load-balancer group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "http"
    port = "9292"
  }

  zone = "${var.zone}"
}

resource "google_compute_global_forwarding_rule" "http" {
  project    = "${var.project}"
  name       = "${var.name}"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  ip_address = "${google_compute_global_address.default.address}"
  port_range = "80"
  depends_on = ["google_compute_global_address.default"]
}

resource "google_compute_global_address" "default" {
  project = "${var.project}"
  name    = "${var.name}-address"
}

# HTTP proxy when ssl is false
resource "google_compute_target_http_proxy" "default" {
  project = "${var.project}"
  name    = "${var.name}-http-proxy"
  url_map = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
  project         = "${var.project}"
  name            = "${var.name}-url-map"
  default_service = "${google_compute_backend_service.default.self_link}"
}

resource "google_compute_backend_service" "default" {
  project          = "${var.project}"
  name             = "${var.name}-backend-${count.index}"
  port_name        = "http"
  protocol         = "HTTP"
  timeout_sec      = 10
  session_affinity = "CLIENT_IP"

  backend {
    group = "${google_compute_instance_group.reddit-app.self_link}"
  }

  health_checks = ["${element(google_compute_http_health_check.default.*.self_link, count.index)}"]

  #health_checks = ["$google_compute_http_health_check.default.self_link"]
}

resource "google_compute_http_health_check" "default" {
  project      = "${var.project}"
  name         = "${var.name}-backend"
  request_path = "/"
  port         = "9292"
}

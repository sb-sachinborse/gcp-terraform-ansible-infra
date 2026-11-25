resource "google_service_account" "vm" {
  account_id   = "${var.name}-web-sa"
  display_name = "${var.name} web VM service account"
}

resource "google_compute_address" "static_ip" {
  name = "${var.name}-web-ip"
}

resource "google_compute_instance" "web" {
  name         = "${var.name}-web"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["web", "ssh"]
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
  }

  network_interface {
    subnetwork = var.subnet_id

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    # Classic metadata SSH keys (not OS Login) so Ansible can connect simply.
    enable-oslogin = "FALSE"
    ssh-keys       = "${var.ssh_user}:${var.ssh_public_key}"
  }

  service_account {
    email  = google_service_account.vm.email
    scopes = ["logging-write", "monitoring-write"]
  }
}

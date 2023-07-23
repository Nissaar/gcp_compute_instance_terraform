
resource "google_compute_network" "vpc_network" {
   name = var.vpc_name
}

resource "google_compute_subnetwork" "public-subnetwork" {
   name = var.subnet_name
   ip_cidr_range = var.ip_cidr_range
   region = var.region
   network = google_compute_network.vpc_network.name
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      labels = {
        my_label = var.disk_label
      }
    }
  }

  metadata = {
  }

  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_name

    access_config {
      // Ephemeral public IP
    }
  }
  #depends_on = google_compute_subnetwork.public-subnetwork.terraform-subnetwork 
  #depends_on = google_compute_subnetwork.public-subnetwork.name 
  depends_on = [
    google_compute_subnetwork.public-subnetwork
  ]
}

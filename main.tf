
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
    ssh-keys = "mushir:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC790FWx9ExxjHoOE/IvzF99D6gUGRjIH5v0EItOg4k4+FAba7tXfejrd/xhKX7P/rlEgiRI8+Rnj/qVPsHbbZ7yanyPPc1hN3GdsMU43PQe8XTEX0+1kOS4RgMen9yzn0in5BfpGDcl6Rjz8RWFcENk1By14FAgf4pbSezXZEdQfWa15T70pJxzJJ7IOrvllvFLRwcdLaVbDwWtJoBGMK2kSxkHMeto0yc4p63hv0o2fGBp1qmqIqgguYLMtZlAoVgN2CxzWLNzlZQrVoGheQ4i2GxXj9PQA2GzFILYSkGran8855WvZ+z5jt01Jns905st/nqbT1T5/z26P1NYrpjPXZU+id8PLinMcanDGVq99GbTEj1EMmbj6OYmMfbm508f89m10uuNSGojUjBQcdnESOXkr5Q7hY/+8zfLgguQSBDGFPawpyiH9vX9ldwaIQ4I2pwjm57Tg/f7yB7EBijfA9sbbBaA+IJ1Hg/DoZ6xpVxGpiXyg6nJgIDGXMZQi0= mushir@LAPTOP-6N82N8E6"
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

provider "google" {
    version = "~>3.38"


    credentials = file ("service-account.json")

    project = "project_id"
    region = "asia-southeast1"
    zone = "asia-southeast1-a"

}

resource "google_compute_instance" "appserver" {
    name = ""
    machine_type = "f1-micro"

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"
      }
    }

network_interface {
  network = "default"
}

}


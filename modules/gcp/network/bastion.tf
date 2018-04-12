# TODO: Make this work to avoid the hard coded link for the image
# data "google_compute_image" "image" {
#   name    = "ubuntu-1604-lts"
#   project = "ubuntu-os-cloud"
# }

# Create a bastion instance in the public network to allow us to ssh on the k8s nodes if needed
resource "google_compute_instance" "bastion" {
  name         = "battlesnake-bastion"
  project      = "${var.project}"
  machine_type = "${var.instance_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      # image = "${data.google_compute_image.image.self_link}"
      image = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1604-xenial-v20180405"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.battlesnake-public.self_link}"

    access_config {
      # Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  tags = ["bastion"]
}

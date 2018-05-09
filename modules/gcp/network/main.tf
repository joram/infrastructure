resource "google_compute_network" "battlesnake_network" {
  name                    = "battlesnake"
  auto_create_subnetworks = "false"
  project                 = "${var.project}"
}

resource "google_compute_subnetwork" "battlesnake-private" {
  name                     = "battlesnake-private"
  ip_cidr_range            = "${var.ip_cidr_range_private}"
  network                  = "${google_compute_network.battlesnake_network.name}"
  region                   = "${var.region}"
  project                  = "${var.project}"
  private_ip_google_access = "true"

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.3.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.4.0.0/16"
  }
}

resource "google_compute_subnetwork" "battlesnake-public" {
  name                     = "battlesnake-public"
  ip_cidr_range            = "${var.ip_cidr_range_public}"
  network                  = "${google_compute_network.battlesnake_network.name}"
  region                   = "${var.region}"
  project                  = "${var.project}"
  private_ip_google_access = "true"
}

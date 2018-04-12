resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  project = "${var.project}"
  network = "${google_compute_network.battlesnake_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = [
    "${google_compute_subnetwork.battlesnake-private.ip_cidr_range}",
    "${google_compute_subnetwork.battlesnake-public.ip_cidr_range}",
  ]
}

resource "google_compute_firewall" "allow-ssh-from-everywhere-to-bastion" {
  name    = "allow-ssh-from-everywhere-to-bastion"
  project = "${var.project}"
  network = "${google_compute_network.battlesnake_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["bastion"]
}

resource "google_compute_firewall" "allow-ssh-from-bastion-to-private-network" {
  name      = "allow-ssh-from-bastion-to-private-network"
  project   = "${var.project}"
  network   = "${google_compute_network.battlesnake_network.name}"
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}

resource "google_compute_firewall" "allow-ssh-to-private-network-from-bastion" {
  name      = "allow-ssh-to-private-network-from-bastion"
  project   = "${var.project}"
  network   = "${google_compute_network.battlesnake_network.name}"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]
}

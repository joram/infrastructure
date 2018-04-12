# Creates the firewall rule to allow traffic between loadbalancers and the k8s nodes
resource "google_compute_firewall" "allow-loadbalancer-to-nodes" {
  name      = "allow-loadbalancer-to-nodes"
  project   = "${var.project}"
  network   = "battlesnake"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # Range of IPs from the GCP loadbalancers
  source_ranges = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16", "130.211.0.0/22"]

  # The firewall rule will be apply to the instances tagged with the follwoing tags
  target_tags = ["k8s-nodes"]
}

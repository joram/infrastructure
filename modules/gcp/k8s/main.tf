# Creates a regional k8s cluster. A regional cluster will create a node in each zone of the region.
resource "google_container_cluster" "battlesnake-k8s-gke" {
  name               = "battlesnake-k8s-gke"
  region             = "${var.region}"
  project            = "${var.project}"
  min_master_version = "${var.min_master_version}"
  logging_service    = "logging.googleapis.com"
  monitoring_service = "monitoring.googleapis.com"
  network            = "battlesnake"               # Network created with the network module
  subnetwork         = "battlesnake-private"       # Subnetwork created with the network module
  initial_node_count = "1"

  # IPs, CIDR blocks allow to connect to the cluster ( kubectl )
  # TODO find a way to pass this as a var 
  master_authorized_networks_config {
    cidr_blocks = {
      cidr_block = "0.0.0.0/0"

      display_name = "All"
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  master_auth {
    username = "battlesnake"
    password = "battlesnake-2019"
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = true
    }

    # Disable dashboard since it is deprecated in GKE
    kubernetes_dashboard {
      disabled = true
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "07:00"
    }
  }

  node_config {
    preemptible  = false
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size_gb}"
    tags         = ["ssh", "k8s-nodes"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",       # This is needed for external-dns addon
    ]
  }
}

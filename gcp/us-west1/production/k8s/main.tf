provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-states-battlesnakeio"
    prefix = "battlesnake/k8s"
  }
  required_version = "= 0.11.7"
}

module "k8s" {
  source             = "../../../../modules/gcp/k8s"
  project            = "battlesnake-io"
  region             = "us-west1"
  min_master_version = "1.9.6-gke.0"
  min_nodes_version  = "1.9.6-gke.0"
  machine_type       = "n1-standard-2"
  disk_size_gb       = "64"
}

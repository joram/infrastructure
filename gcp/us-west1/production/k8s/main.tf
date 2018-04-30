provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-battlesnake-io"
    prefix = "battlesnake/k8s"
  }

  required_version = "= 0.11.7"
}

module "k8s" {
  source             = "../../../../modules/gcp/k8s"
  projects           = "battlesnake-io"
  region             = "us-west1"
  min_master_version = "1.9.6-gke.1"
  min_nodes_version  = "1.9.6-gke.1"
  machine_type       = "n1-standard-2"
  disk_size_gb       = "64"
}

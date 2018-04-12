provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-states-battlesnakeio" # Need to be change for your infra
    prefix = "battlesnake/k8s"
  }
}

data "terraform_remote_state" "base" {
  backend = "gcs"

  config {
    bucket = "terraform-states-battlesnakeio" # Need to be change for your infra
    prefix = "battlesnake/base"
  }
}

module "k8s" {
  source             = "../../modules/gcp/k8s"
  project            = "${data.terraform_remote_state.base.project_id}"
  region             = "us-west1"
  min_master_version = "1.9.6-gke.0"
  machine_type       = "n1-standard-1"
  disk_size_gb       = "64"
}

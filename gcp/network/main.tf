provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-states-battlesnakeio" # Need to be change for your infra
    prefix = "battlesnake/network"
  }
}

data "terraform_remote_state" "base" {
  backend = "gcs"

  config {
    bucket = "terraform-states-battlesnakeio" # Need to be change for your infra
    prefix = "battlesnake/base"
  }
}

module "network" {
  source  = "../../modules/gcp/network"
  project = "${data.terraform_remote_state.base.project_id}"
}

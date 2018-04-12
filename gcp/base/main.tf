provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-states-battlesnakeio" # Need to be change for your infra
    prefix = "battlesnake/base"
  }
}

module "project" {
  source     = "../../modules/gcp/project"
  org_domain = "battlesnake.io"            # Need to be change for your project
}

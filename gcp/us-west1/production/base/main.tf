provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-states-battlesnakeio"
    prefix = "battlesnake/base"
  }
  required_version = "= 0.11.7"
}

module "project" {
  source  = "../../../../modules/gcp/project"
  project = "battlesnake-io"
}

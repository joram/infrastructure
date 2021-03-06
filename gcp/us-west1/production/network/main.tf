provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-battlesnake-io"
    prefix = "battlesnake/network"
  }

  required_version = "= 0.11.7"
}

module "network" {
  source  = "../../../../modules/gcp/network"
  project = "battlesnake-io"
}

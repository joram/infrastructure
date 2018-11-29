provider "google" {
  region  = "us-west1"
  project = "battlesnake-io"
}

terraform {
  backend "gcs" {
    bucket = "terraform-battlesnake-io"
    prefix = "battlesnake/sql"
  }

  required_version = "= 0.11.7"
}


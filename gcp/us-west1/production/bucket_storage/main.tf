 provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-battlesnake-io"
    prefix = "battlesnake/bucket_storage"
  }

  required_version = "= 0.11.7"
}


resource "google_storage_bucket" "snakedown-snapshots" {
  name     = "snakedown-2018-snapshots-battlesnake-io"
  region = "us-west1"
}

resource "google_storage_bucket_acl" "snakedown-snapshots-acl" {
 bucket = "${google_storage_bucket.snakedown-snapshots.name}"
 predefined_acl = "publicread"
}
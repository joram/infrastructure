provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-battlesnake-io"
    prefix = "battlesnake/k8s_secrets"
  }

  required_version = "= 0.11.7"
}

provider "kubernetes" {
  
}

data "terraform_remote_state" "sql" {
  backend   = "gcs"
  config {
    bucket  = "terraform-battlesnake-io"
    prefix  = "battlesnake/sql"
  }
}

resource "kubernetes_secret" "cloudsql-play-instance-credentials" {
  metadata {
    name               = "cloudsql-play-instance-credentials"
    namespace          = "default"
  }
  data {
    "credentials.json" = "${base64decode(data.terraform_remote_state.sql.cloudsqlproxy-play-service-account-private-key)}"
  }
}

resource "kubernetes_secret" "cloudsql-play-db-credentials" {
  metadata {
    name       = "cloudsql-play-db-credentials"
    namespace  = "default"
  }
  data {
    username   = "${data.terraform_remote_state.sql.db_user_name}"
    password   = "${data.terraform_remote_state.sql.generated_user_password}"
  }
}

resource "kubernetes_secret" "cloudsql-play-db-config" {
  metadata {
    name              = "cloudsql-play-db-config"
    namespace         = "default"
  }
  data {
    connection_name   = "${data.terraform_remote_state.sql.connection_name}"
    instance_address  = "${data.terraform_remote_state.sql.instance_address}"
    instance_name     = "${data.terraform_remote_state.sql.instance_name}"
  }
}

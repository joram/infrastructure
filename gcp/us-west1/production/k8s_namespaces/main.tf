provider "google" {
  region = "us-west1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-battlesnake-io"
    prefix = "battlesnake/k8s_namespaces"
  }

  required_version = "= 0.11.7"
}

provider "kubernetes" {
  
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

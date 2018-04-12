data "google_organization" "org" {
  domain = "${var.org_domain}"
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "random_id" "battlesnake" {
  byte_length = 3
}

resource "google_project" "battlesnake" {
  name            = "battlesnake"
  project_id      = "battlesnake-${random_id.battlesnake.dec}"
  org_id          = "${data.google_organization.org.id}"
  billing_account = "${data.google_billing_account.acct.id}"
}

resource "google_project_services" "battlesnake" {
  project = "${google_project.battlesnake.project_id}"

  services = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "containerregistry.googleapis.com",
    "pubsub.googleapis.com",
    "deploymentmanager.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

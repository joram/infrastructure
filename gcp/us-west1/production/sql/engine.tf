module "postgresql-engine" {
  source                      = "../../../../modules/gcp/sql"

  project                     = "battlesnake-io"

  name                        = "battlesnake-engine"
  database_version            = "POSTGRES_9_6"
  region                      = "us-west1"
  tier                        = "db-custom-2-4096" # 2 CPU, 4GB ram
  activation_policy           = "ALWAYS"
  availability_type           = "REGIONAL"
  disk_autoresize             = "true"
  disk_size                   = "100"
  disk_type                   = "PD_SSD"
  backup_configuration        = [{
    enabled = "true"
    start_time = "00:00"
  }]
  maintenance_window          = [{
    day = "7"
    hour = "23"
    update_track = "stable"
  }]

  db_name                     = "engine"
  db_charset                  = "UTF8"
  db_collation                = "en_US.UTF8"

}

module "db-user-engine" {
  source    = "../../../../modules/gcp/sql_user"

  project   = "battlesnake-io"

  user_name = "proxyuser"
  instance = "${module.postgresql-engine.instance_name}"
  
}

module "cloudsqlproxy-engine-service-account" {
  source        = "../../../../modules/gcp/service_account"
  
  account_id    = "cloudsqlproxy-engine"
  display_name  = "cloudsqlproxy-engine"
  project       = "battlesnake-io"
}

module "cloudsqlproxy-engine-service-account-key" {
  source = "../../../../modules/gcp/service_account_key"

  service_account_id = "${module.cloudsqlproxy-engine-service-account.name}"
}

module "cloudsqlproxy-engine-binding-cloudsql-client" {
  source                = "../../../../modules/gcp/project_iam_binding"

  project               = "battlesnake-io"

  role                  = "roles/cloudsql.client"
  members               = ["serviceAccount:${module.cloudsqlproxy-engine-service-account.email}"]
}

module "cloudsqlproxy-engine-binding-cloudsql-editor" {
  source                = "../../../../modules/gcp/project_iam_binding"
  
  project               = "battlesnake-io"

  role                  = "roles/cloudsql.editor"
  members               = ["serviceAccount:${module.cloudsqlproxy-engine-service-account.email}"]
}

module "cloudsqlproxy-engine-binding-cloudsql-admin" {
  source                = "../../../../modules/gcp/project_iam_binding"

  project               = "battlesnake-io"

  role                  = "roles/cloudsql.admin"
  members               = ["serviceAccount:${module.cloudsqlproxy-engine-service-account.email}"]
}

resource "google_sql_database_instance" "default" {
  name              = "${var.name}"
  database_version  = "${var.database_version}"
  region            = "${var.region}"
  project           = "${var.project}"


  settings {
    tier                        = "${var.tier}"
    activation_policy           = "${var.activation_policy}"
    availability_type           = "${var.availability_type}"
    disk_autoresize             = "${var.disk_autoresize}"
    disk_size                   = "${var.disk_size}"
    disk_type                   = "${var.disk_type}"
    backup_configuration        = ["${var.backup_configuration}"]
    ip_configuration            = ["${var.ip_configuration}"]
    maintenance_window          = ["${var.maintenance_window}"]
  }
}

resource "google_sql_database" "default" {
  name      = "${var.db_name}"
  project   = "${var.project}"
  instance  = "${google_sql_database_instance.default.name}"
  charset   = "${var.db_charset}"
  collation = "${var.db_collation}"
}


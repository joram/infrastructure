resource "random_id" "user-password" {
  byte_length = 32
}

resource "google_sql_user" "default" {
  name     = "${var.user_name}"
  project  = "${var.project}"
  instance = "${var.instance}"
  password = "${var.user_password == "" ? random_id.user-password.hex : var.user_password}"
}

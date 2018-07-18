output "generated_user_password" {
  description = "The auto generated default user password if no input password was provided"
  value       = "${random_id.user-password.hex}"
  sensitive   = true
}
output "name" {
  value = "${google_sql_user.default.name}"
  description = "The name of the user"
}
output "password" {
  value = "${google_sql_user.default.password}"
  description = "The password for the user"
  sensitive   = true
}

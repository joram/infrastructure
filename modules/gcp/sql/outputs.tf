output "instance_name" {
  description = "The name of the database instance"
  value       = "${google_sql_database_instance.default.name}"
}
output "instance_address" {
  description = "The IPv4 address of the master database instnace"
  value       = "${google_sql_database_instance.default.ip_address.0.ip_address}"
}
output "self_link" {
  description = "Self link to the master instance"
  value       = "${google_sql_database_instance.default.self_link}"
}
output "connection_name" {
  description = "The connection name of the instance to be used in connection strings"
  value       = "${google_sql_database_instance.default.connection_name}"
}

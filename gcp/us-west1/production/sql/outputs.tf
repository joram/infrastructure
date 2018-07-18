output "instance_name" {
  value = "${module.postgresql-play.instance_name}"
}
output "instance_address" {
  value = "${module.postgresql-play.instance_address}"
}
output "self_link" {
  value = "${module.postgresql-play.self_link}"
}
output "generated_user_password" {
  value       = "${module.db-user.generated_user_password}"
  sensitive   = true
}
output "db_user_name" {
  value = "${module.db-user.name}"
}
output "connection_name" {
  value = "${module.postgresql-play.connection_name}"
}
output "cloudsqlproxy-play-service-account-id" {
  value = "${module.cloudsqlproxy-play-service-account.id}"
}
output "cloudsqlproxy-play-service-account-private-key" {
  value       = "${module.cloudsqlproxy-play-service-account-key.private_key}"
  sensitive   = true
}

output "instance_name" {
  value = "${module.postgresql-play.instance_name}"
}
output "instance_name_engine" {
  value = "${module.postgresql-engine.instance_name}"
}
output "instance_address" {
  value = "${module.postgresql-play.instance_address}"
}
output "instance_address_engine" {
  value = "${module.postgresql-engine.instance_address}"
}
output "self_link" {
  value = "${module.postgresql-play.self_link}"
}
output "self_link_engine" {
  value = "${module.postgresql-engine.self_link}"
}
output "generated_user_password" {
  value       = "${module.db-user.generated_user_password}"
  sensitive   = true
}
output "generated_user_password_engine" {
  value       = "${module.db-user-engine.generated_user_password}"
  sensitive   = true
}
output "db_user_name" {
  value = "${module.db-user.name}"
}
output "db_user_name_engine" {
  value = "${module.db-user-engine.name}"
}
output "connection_name" {
  value = "${module.postgresql-play.connection_name}"
}
output "connection_name_engine" {
  value = "${module.postgresql-engine.connection_name}"
}
output "cloudsqlproxy-play-service-account-id" {
  value = "${module.cloudsqlproxy-play-service-account.id}"
}
output "cloudsqlproxy-engine-service-account-id" {
  value = "${module.cloudsqlproxy-engine-service-account.id}"
}
output "cloudsqlproxy-play-service-account-private-key" {
  value       = "${module.cloudsqlproxy-play-service-account-key.private_key}"
  sensitive   = true
}
output "cloudsqlproxy-engine-service-account-private-key" {
  value       = "${module.cloudsqlproxy-engine-service-account-key.private_key}"
  sensitive   = true
}

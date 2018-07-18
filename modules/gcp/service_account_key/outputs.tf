output "name" {
  value = "${google_service_account_key.main.name}"
}
output "private_key" {
  value = "${google_service_account_key.main.private_key}"
}

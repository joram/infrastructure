output "network_name" {
  value = "${module.network.network_name}"
}

output "network_self_link" {
  value = "${module.network.network_self_link}"
}

output "private_subnetwork_self_link" {
  value = "${module.network.private_subnetwork_self_link}"
}

output "private_subnetwork_name" {
  value = "${module.network.private_subnetwork_name}"
}

output "public_subnetwork_self_link" {
  value = "${module.network.public_subnetwork_self_link}"
}

output "public_subnetwork_name" {
  value = "${module.network.public_subnetwork_name}"
}

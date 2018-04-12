output "network_name" {
  value = "${google_compute_network.battlesnake_network.name}"
}

output "network_self_link" {
  value = "${google_compute_network.battlesnake_network.self_link}"
}

output "private_subnetwork_self_link" {
  value = "${google_compute_subnetwork.battlesnake-private.self_link}"
}

output "private_subnetwork_name" {
  value = "${google_compute_subnetwork.battlesnake-private.name}"
}

output "public_subnetwork_self_link" {
  value = "${google_compute_subnetwork.battlesnake-public.self_link}"
}

output "public_subnetwork_name" {
  value = "${google_compute_subnetwork.battlesnake-public.name}"
}

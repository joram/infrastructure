variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "region" {
  description = "The region this subnetwork will be created in. If unspecified, this defaults to the region configured in the provider"
}

variable "min_master_version" {
  description = "The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version"
}

variable "machine_type" {
  description = "The name of a Google Compute Engine machine type"
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB"
}

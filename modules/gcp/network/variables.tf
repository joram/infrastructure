variable "project" {
  description = "The ID of the project in which the resource belongs"
}

variable "region" {
  description = "The region this subnetwork will be created in"
  default     = "us-west1"
}

variable "ip_cidr_range_public" {
  description = "The IP address range that machines in this network are assigned to, represented as a CIDR block."
  default     = "10.1.0.0/16"
}

variable "ip_cidr_range_private" {
  description = "The IP address range that machines in this network are assigned to, represented as a CIDR block."
  default     = "10.2.0.0/16"
}

variable "instance_type" {
  description = "The name of a Google Compute Engine machine type"
  default     = "f1-micro"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "us-west1-a"
}

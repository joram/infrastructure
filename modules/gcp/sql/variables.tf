variable "project" {
  default = ""
}
variable "name" {
  default = ""
}
variable "database_version" {
  default = ""
}
variable "region" {
  default = "us-west1"
}
variable "tier" {
  default = "db-f1-micro"
}
variable "activation_policy" {
  default = "ALWAYS"
}
variable "availability_type" {
  default = "REGIONAL"
}
variable "disk_autoresize" {
  default = "false"
}
variable "disk_size" {
  default = "10"
}
variable "disk_type" {
  default = "PD_SSD"
}
variable "backup_configuration" {
  type = "map"
  default = {}
}
variable "ip_configuration" {
  type = "list"
  default = [{}]
}
variable "maintenance_window" {
  type = "list"
  default = []
}
variable "db_name" {
  default = ""
}
variable "db_charset" {
  default = "UTF8"
}
variable "db_collation" {
  default = "en_US.UTF8"
}

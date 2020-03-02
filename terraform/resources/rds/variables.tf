######### RDS ###########
variable "database_instance_name" {
    type = "string"
}
variable "database_instance_type" {
    type = "string"
}
variable "database_cluster_name" {
    type = "string"
}
variable "database_engine_type" {
    type = "string"
}
variable "database_zones" {
    type = "list"
}
variable "database_name" {
    type = "string"
}
variable "database_username" {
    type = "string"
}
variable "database_password" {
    type = "string"
}
variable "security_group_id" {
    type = "string"
}
variable "database_engine_version" {
    type = "string"
}
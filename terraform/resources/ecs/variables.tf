variable "ecs_cluster_name" {
    type = "string"
}
variable "ecs_service_desired_count" {
}
variable "ecs_service_name" {
    type = "string"
}
variable "ecs_service_launch_type" {
    type = "string"
}
variable "ecs_service_container_name" {
    type = "string"
}
variable "ecs_service_container_port" {
}
variable "ecs_task_definition_name" {
    type = "string"
}
variable "ecr_url" {
    type = "string"
}
variable "database_url" {
    type = "string"
}
variable "database_name" {
    type = "string"
}
variable "database_user" {
    type = "string"
}
variable "database_pass" {
    type = "string"
}
variable "target_group_arn" {
    type = "string"
}

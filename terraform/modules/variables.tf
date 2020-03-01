######### RDS ###########
variable "database_instance_name" {
    type = "string"
    default = "aurora-database-instance"
}
variable "database_instance_type" {
    type = "string"
    default = "db.t2.small"
}
variable "database_cluster_name" {
    type = "string"
    default = "aurora-cluster-service"
}
variable "database_engine_type" {
    type = "string"
    default = "aurora-mysql"
}
variable "database_zones" {
    type = "list"
    default = ["us-east-1a", "us-east-1a"]
}
variable "database_name" {
    type = "string"
    default = "rds"
}
variable "database_username" {
    type = "string"
    default = "server1"
}
variable "database_password" {
    type = "string"
}
######### VPC ###########
variable "cird_block" {
    type = "string"
    default = "10.0.0.0/16"
}

####### SUBNETS #########
variable "public_subnet" {
    type = "map"
    default = {
        "zone" = "us-east-1a"
        "subnet" = "10.0.1.0/24"
        "tag" = "cg_public_subnet"
    }
}
variable "private_subnet" {
    type = "map"
    default = {
        "zone" = "us-east-1b"
        "subnet" = "10.0.2.0/24"
        "tag" = "cg_private_subnet"
    }
}
####### ROUTES #########
variable "routes_public" {
    type = "map"
    default = {
        "cidr" = "0.0.0.0/0"
        "tag" = "public_route_cg"
        "is_public" = true
    }
}
variable "routes_private" {
    type = "map"
    default = {
        "cidr" = ""
        "tag" = "private_route_cg"
        "is_public" = false
    }
}
####### SG #########
variable "sg_in_protocol" {
    type = "list"
    default = ["tcp"]
}
variable "sg_in_from_port" {
    type = "list"
    default = [0]
}
variable "sg_in_to_port" {
    type = "list"
    default = [0]
}
variable "sg_in_cidr" {
    type = "list"
    default = ["0.0.0.0/0"]
}
variable "sg_name" {
    type = "string"
    default = "sg_general"
}
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
    default = "aurora"
}
variable "database_zones" {
    type = "list"
    default = ["us-east-1b", "us-east-1d", "us-east-1e"]
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
variable "database_engine_version" {
    type = "string"
    default = "5.6.10a"
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
variable "private_subnet-c" {
    type = "map"
    default = {
        "zone" = "us-east-1c"
        "subnet" = "10.0.3.0/24"
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
variable "sg_aurora_name" {
    type = "string"
    default = "sg_aurora"
}
variable "sg_ecs_name" {
    type = "string"
    default = "sg_ecs"
}
####### ECR #########
variable "ecr_name" {
    type = "string"
    default = "ecr-cg"
}
####### ECS #########
variable "ecs_cluster_name" {
    type = "string"
    default = "ecs-cluster-cg"
}
variable "ecs_service_name" {
    type = "string"
    default = "backend"
}
variable "ecs_service_desired_count" {
    default = 1
}
variable "ecs_service_launch_type" {
    type = "string"
    default = "EC2"
}
variable "ecs_service_container_name" {
    type = "string"
    default = "backend"
}
variable "ecs_service_container_port" {
    default = 8080
}
variable "ecs_task_definition_name" {
    type = "string"
    default = "backend-task-definition"
}
####### ALB #########
variable "alb_name" {
    type = "string"
    default = "alb"
}
####### ASG #########
variable "ecs_instance_type" {
    type = "string"
    default = "t2.micro"
}
variable "spot_bid_price" {
    type = "string"
    default = "0.0113"
}
variable "ecs_max_count" {
    type = "string"
    default = "1"
}
variable "ecs_min_count" {
    type = "string"
    default = "1"
}
module "database"{
    source = "../resources/rds"
    database_instance_name = "${var.database_instance_name}"
    database_instance_type = "${var.database_instance_type}"
    database_cluster_name = "${var.database_cluster_name}"
    database_engine_type = "${var.database_engine_type}"
    database_engine_version = "${var.database_engine_version}"
    database_zones = "${var.database_zones}"
    database_name = "${var.database_name}"
    database_username = "${var.database_username}"
    database_password = "${var.database_password}"
    security_group_id = "${module.security_group_aurora.security_group_id}"
}
module "vpc" {
    source = "../resources/vpc"
    cird = "${var.cird_block}"
}
module "public_subnet" {
    source = "../resources/subnet"
    subnet = "${var.public_subnet}"
    vpc_id = "${module.vpc.vpc_id}"
    route_table_id = "${module.route_public.route_table_public_id[0]}"
}
module "private_subnet" {
    source = "../resources/subnet"
    subnet = "${var.private_subnet}"
    vpc_id = "${module.vpc.vpc_id}"
    route_table_id = "${module.route_private.route_table_private_id[0]}"
}
module "private_subnet_c" {
    source = "../resources/subnet"
    subnet = "${var.private_subnet-c}"
    vpc_id = "${module.vpc.vpc_id}"
    route_table_id = "${module.route_private.route_table_private_id[0]}"
}
module "internet_gateway"{
    source = "../resources/internet_gateway"
    vpc_id = "${module.vpc.vpc_id}"
}
module "route_public" {
    source = "../resources/routes"
    vpc_id = "${module.vpc.vpc_id}"
    gw_id = "${module.internet_gateway.gw_id}"
    routes = "${var.routes_public}"
}
module "route_private" {
    source = "../resources/routes"
    vpc_id = "${module.vpc.vpc_id}"
    gw_id = ""
    routes = "${var.routes_private}"
}
module "security_group" {
    source = "../resources/sg"
    vpc_id = "${module.vpc.vpc_id}"
    sg_in_protocol = "${var.sg_in_protocol}"
    sg_in_from_port = "${var.sg_in_from_port}"
    sg_in_to_port = "${var.sg_in_to_port}"
    sg_in_cidr = "${var.sg_in_cidr}"
    sg_name = "${var.sg_name}"
}
module "security_group_ecs" {
    source = "../resources/sg"
    vpc_id = "${module.vpc.vpc_id}"
    sg_in_protocol = "${var.sg_in_protocol}"
    sg_in_from_port = "${var.sg_in_from_port}"
    sg_in_to_port = "${var.sg_in_to_port}"
    sg_in_cidr = "${var.sg_in_cidr}"
    sg_name = "${var.sg_ecs_name}"
}
module "security_group_aurora" {
    source = "../resources/sg"
    vpc_id = "${module.vpc.default_vpc_id}"
    sg_in_protocol = "${var.sg_in_protocol}"
    sg_in_from_port = "${var.sg_in_from_port}"
    sg_in_to_port = "${var.sg_in_to_port}"
    sg_in_cidr = "${var.sg_in_cidr}"
    sg_name = "${var.sg_aurora_name}"
}
module "ecr" {
    source = "../resources/ecr"
    ecr_name = "${var.ecr_name}"
}
module "ecs_cluster" {
    source = "../resources/ecs"
    ecs_cluster_name = "${var.ecs_cluster_name}"
    ecs_service_name = "${var.ecs_service_name}"
    ecs_service_desired_count = "${var.ecs_service_desired_count}"
    ecs_service_launch_type = "${var.ecs_service_launch_type}"
    ecs_service_container_name = "${var.ecs_service_container_name}"
    ecs_service_container_port = "${var.ecs_service_container_port}"
    ecs_task_definition_name = "${var.ecs_task_definition_name}"
    ecs_service_launch_type = "${var.ecs_service_launch_type}"
    ecr_url = "${module.ecr.ecr_url}"
    database_url = "${module.database.rds_endpoint}"
    database_user = "${var.database_username}"
    database_name = "${var.database_name}"
    database_pass = "${var.database_password}"
    target_group_arn = "${module.alb.alb_target_group_arn}"
}
module "alb" {
    source = "../resources/alb"
    security_groups_id = "${module.security_group_ecs.security_group_id}"
    ecs_service_container_port = "${var.ecs_service_container_port}"
    vpc_id = "${module.vpc.vpc_id}"
    subnets_id = ["${module.private_subnet.subnet_id}", "${module.private_subnet_c.subnet_id}"]
    alb_name = "${var.alb_name}"
}

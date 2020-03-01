module "database"{
    source = "../resources/rds"
    database_instance_name = "${var.database_instance_name}"
    database_instance_type = "${var.database_instance_type}"
    database_cluster_name = "${var.database_cluster_name}"
    database_engine_type = "${var.database_engine_type}"
    database_zones = "${var.database_zones}"
    database_name = "${var.database_name}"
    database_username = "${var.database_username}"
    database_password = "${var.database_password}"
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
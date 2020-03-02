output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
output "public_subnet_id" {
  value = "${module.public_subnet.subnet_id}"
}
output "private_subnet_id" {
  value = "${module.private_subnet.subnet_id}"
}
output "private_subnet_c_id" {
  value = "${module.private_subnet_c.subnet_id}"
}
output "gw_id" {
  value = "${module.internet_gateway.gw_id}"
}
output "route_public_id" {
  value = "${module.route_public.route_table_public_id}"
}
output "route_private_id" {
  value = "${module.route_private.route_table_private_id}"
}
output "security_group_id" {
  value = "${module.security_group.security_group_id}"
}
output "default_vpc_id" {
    value = "${module.vpc.default_vpc_id}"
}
output "security_group_aurora_id" {
  value = "${module.security_group_aurora.security_group_id}"
}
output "security_group_ecs_id" {
  value = "${module.security_group_ecs.security_group_id}"
}
output "rds_endpoint" {
  value = "${module.database.rds_endpoint}"
}
output "ecr_endpoint" {
  value = "${module.ecr.ecr_url}"
}
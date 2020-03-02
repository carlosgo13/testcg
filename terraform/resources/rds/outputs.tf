output "rds_endpoint" {
    value = "${aws_rds_cluster_instance.cluster_instances.endpoint}"
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.database_instance_name}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "${var.database_instance_type}"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "${var.database_cluster_name}"
  engine                  = "${var.database_engine_type}"
  availability_zones      = "${var.database_zones}"
  database_name           = "${var.database_name}"
  master_username         = "${var.database_username}"
  master_password         = "${var.database_password}"
  skip_final_snapshot     = true
}
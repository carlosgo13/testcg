resource "aws_ecs_cluster" "cluster" {
    name = "${var.ecs_cluster_name}"
}
resource "aws_ecs_capacity_provider" "main" {
  name = "capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = "${aws_autoscaling_group.ecs_cluster_spot.arn}"
  }
}
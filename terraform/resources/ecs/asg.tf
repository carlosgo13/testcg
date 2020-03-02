resource "aws_autoscaling_group" "ecs_cluster_spot" {
  name_prefix = "${var.ecs_cluster_name}_asg_spot_"
  termination_policies = [
     "OldestInstance"
  ]
  default_cooldown          = 30
  health_check_grace_period = 30
  max_size                  = "${var.ecs_max_count}"
  min_size                  = "${var.ecs_min_count}"
  desired_capacity          = "${var.ecs_min_count}"
  launch_configuration      = "${aws_launch_configuration.ecs_config_launch_config_spot.name}"

  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier = ["${var.subnets_id}"]

  tags = {
    key = "Name" 
    value = "${var.ecs_cluster_name}"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "ecs_cluster_scale_policy" {
  name = "${var.ecs_cluster_name}_ecs_cluster_spot_scale_policy"
  policy_type = "TargetTrackingScaling"
  adjustment_type = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.ecs_cluster_spot.name}"

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name = "ClusterName"
        value = "${var.ecs_cluster_name}"
      }
      metric_name = "MemoryReservation"
      namespace = "AWS/ECS"
      statistic = "Average"
    }
    target_value = 70.0
  }
}
resource "aws_launch_configuration" "ecs_config_launch_config_spot" {
  name_prefix                 = "${var.ecs_cluster_name}_ecs_cluster_spot"
  image_id                    = "${data.aws_ami.ecs.id}"
  instance_type               = "${var.ecs_instance_type}"
  spot_price                  = "${var.spot_bid_price}"

  enable_monitoring           = true
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
echo ECS_INSTANCE_ATTRIBUTES={\"purchase-option\":\"spot\"} >> /etc/ecs/ecs.config
EOF

  security_groups = [
    "${var.sg_ecs_name}"
  ]
}
data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "amzn2-ami-ecs-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  owners = [
    "amazon"
  ]
}
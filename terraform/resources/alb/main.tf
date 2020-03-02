resource "random_id" "alb" {
  keepers = {
    ami_id = "${var.alb_name}"
  }

  byte_length = 4
}
resource "aws_alb_target_group" "alb_target_group" {
  name     = "alb-target-group-${random_id.alb.hex}"
  port     = "${var.ecs_service_container_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_alb" "alb_openjobs" {
  name            = "alb-openjobs"
  subnets         = ["${var.subnets_id}"]
  security_groups = ["${var.security_groups_id}"]

  tags {
    Name        = "alb-openjobs"
  }
}

resource "aws_alb_listener" "openjobs" {
  load_balancer_arn = "${aws_alb.alb_openjobs.arn}"
  port              = "${var.ecs_service_container_port}"
  protocol          = "HTTP"
  depends_on        = ["aws_alb_target_group.alb_target_group"]

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}
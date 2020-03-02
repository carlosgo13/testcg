output "alb_dns" {
    value = "${aws_alb.alb_openjobs.dns_name}"
}
output "alb_target_group_arn" {
    value = "${aws_alb_target_group.alb_target_group.arn}"
}
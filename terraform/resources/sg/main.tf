resource "aws_security_group" "default" {
    name   = "${var.sg_name}"
    vpc_id = "${var.vpc_id}"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "cg_security_group"
    }
}
resource "aws_security_group_rule" "default" {
    count     = "${length(var.sg_in_protocol)}"
    type      = "ingress"
    protocol  = "${element(var.sg_in_protocol, count.index)}"
    from_port = "${element(var.sg_in_from_port, count.index)}"
    to_port   = "${element(var.sg_in_to_port, count.index)}"
    cidr_blocks = "${var.sg_in_cidr}"
    security_group_id = "${aws_security_group.default.id}"
}
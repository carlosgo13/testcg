resource "aws_subnet" "main" {
    vpc_id = "${var.vpc_id}"
    availability_zone = "${lookup(var.subnet, "zone")}"
    cidr_block = "${lookup(var.subnet, "subnet")}"
    tags = {
    Name = "${lookup(var.subnet, "tag")}"
    }
}
resource "aws_route_table_association" "main" {
    subnet_id      = "${aws_subnet.main.id}"
    route_table_id = "${var.route_table_id}"
}
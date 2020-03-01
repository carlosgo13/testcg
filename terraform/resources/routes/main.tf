resource "aws_route_table" "public" {
    count = "${lookup(var.routes, "is_public") ? 1 : 0}"
    vpc_id = "${var.vpc_id}"
    route {
        cidr_block = "${lookup(var.routes, "cidr")}"        
        gateway_id = "${var.gw_id}"
    }
    tags = {
        Name =  "${lookup(var.routes, "tag")}"
    }
}
resource "aws_route_table" "private" {
    count = "${var.gw_id=="" ? 1 : 0}"
    vpc_id = "${var.vpc_id}"
    tags = {
        Name =  "${lookup(var.routes, "tag")}"
    }
}
######### VPC ###########
output "vpc_id"{
    value = "${aws_vpc.main.id}"
}
output "default_vpc_id" {
    value = "${aws_default_vpc.main.id}"
}
resource "aws_vpc" "main" {
  cidr_block       = "${var.cird}"

  tags = {
    Name = "cg_vpc"
  }
}
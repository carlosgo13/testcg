resource "aws_vpc" "main" {
  cidr_block       = "${var.cird}"

  tags = {
    Name = "cg_vpc"
  }
}
resource "aws_default_vpc" "main"{
  tags = {
    Name = "Default"
  }   
}
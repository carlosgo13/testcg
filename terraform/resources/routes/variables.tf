variable "routes" {
    type = "map"
    default = {
        "cidr" = ""
        "tag" = ""
        "is_public" = ""
    }
}
variable "gw_id" {
    type = "string"
}
variable "vpc_id" {
    type = "string"
}
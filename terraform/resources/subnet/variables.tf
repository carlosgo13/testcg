variable "subnet" {
    type = "map"
    default = {
        "zone" = ""
        "subnet" = ""
        "tag" = ""
    }
}
variable "vpc_id" {
    type = "string"
}
variable "route_table_id" {
    type = "string"
}
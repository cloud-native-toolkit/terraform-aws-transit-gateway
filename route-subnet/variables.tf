variable "transit_gateway_id" {
  type        = string
  description = "Transit Gateway ID"
}

variable "route_table_ids" {
  type        = list(string)
  description = "Subnet route table IDs"
}

variable "destination_cidr_blocks" {
  type        = list(string)
  description = "Destination CIDR blocks"
}



variable "number_subnet_route" {
  type = number
  description = "total nuber of route to add for subnets"
}
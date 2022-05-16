variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default     = "default"
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = ""
}

variable "name_gateway" {
  type = string
  default = ""
  description = "Name of resource  VPN to create."
}
variable "default_route_table_association" {
  type        = string
  default     = "disable"
  description = "Whether resource attachments are automatically associated with the default association route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "default_route_table_propagation" {
  type        = string
  default     = "disable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "dns_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "vpn_ecmp_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "allow_external_principals" {
  type        = bool
  default     = false
  description = "Indicates whether principals outside your organization can be associated with a resource share"
}

variable "vpc_attachment_appliance_mode_support" {
  type        = string
  default     = "disable"
  description = "Whether Appliance Mode support is enabled. If enabled, a traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. Valid values: `disable`, `enable`"
}

variable "vpc_attachment_dns_support" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}

variable "vpc_attachment_ipv6_support" {
  type        = string
  default     = "disable"
  description = "Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: `disable`, `enable`. Default value: `enable`"
}


variable "existing_transit_gateway_id" {
  type        = string
  default     = null
  description = "Existing Transit Gateway ID. If provided, the module will not create a Transit Gateway but instead will use the existing one"
}

variable "existing_transit_gateway_route_table_id" {
  type        = string
  default     = null
  description = "Existing Transit Gateway Route Table ID. If provided, the module will not create a Transit Gateway Route Table but instead will use the existing one"
}
variable "tgw_route_table_association" {
  type        = bool
  default     = true
  description = "Whether to create a Transit Gateway. If set to `false`, an existing Transit Gateway ID must be provided in the variable `existing_transit_gateway_id`"
}
variable "create_transit_gateway" {
  type        = bool
  default     = false
  description = "Whether to create a Transit Gateway. If set to `false`, an existing Transit Gateway ID must be provided in the variable `existing_transit_gateway_id`"
}

variable "create_transit_gateway_route_table" {
  type        = bool
  default     = false
  description = "Whether to create a Transit Gateway Route Table. If set to `false`, an existing Transit Gateway Route Table ID must be provided in the variable `existing_transit_gateway_route_table_id`"
}

variable "create_transit_gateway_vpc_attachment" {
  type        = bool
  default     = false
  description = "Whether to create Transit Gateway VPC Attachments"
}

variable "create_transit_gateway_route_table_association_and_propagation" {
  type        = bool
  default     = true
  description = "Whether to create Transit Gateway Route Table associations and propagations"
}



# variable "route_keys_enabled" {
#   type        = bool
#   default     = false
#   description = <<-EOT
#     If true, Terraform will use keys to label routes, preventing unnecessary changes,
#     but this requires that the VPCs and subnets already exist before using this module.
#     If false, Terraform will use numbers to label routes, and a single change may
#     cascade to a long list of changes because the index or order has changed, but
#     this will work when the `true` setting generates the error `The "for_each" value depends on resource attributes...`
#     EOT
# }

# variable "transit_gateway_cidr_blocks" {
#   type        = list(string)
#   default     = null
#   description = <<-EOT
#     The list of associated CIDR blocks. It can contain up to 1 IPv4 CIDR block
#     of size up to /24 and up to one IPv6 CIDR block of size up to /64. The IPv4
#     block must not be from range 169.254.0.0/16.
#   EOT
# }

variable "transit_gateway_description" {
  type        = string
  default     = "tgw for rosa adbance cluster"
  description = "Transit Gateway description."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC id for edge."
}

variable "vpc_id_menage" {
  type        = string
  default     = ""
  description = "VPC id for menage."
}

variable "vpc_id_work" {
  type        = string
  default     = ""
  description = "VPC id for edge."
}

variable "internal_cidr" {
  type        = string
  default     = ""
  description = "cider rage for edge vpc."
}

variable "internal_cidr_work" {
  type        = string
  default     = ""
  description = "cider rage for work vpc."
}

variable "internal_cidr_menage" {
  type        = string
  default     = ""
  description = "cider rage for work vpc."
}

variable "subnet_priv_ids" {
  type        = list(string)
  default     = []
  description = "subnet ids for edge vpc subnets."
}

variable "route_to_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "subnet ids for edge vpc subnets."
}

variable "route_table_priv_ids" {
  type        = list(string)
  default     = []
  description = "route table ids for all edge vpc subnets."
}
variable "number_subnet_route" {
  default = 6
  description = "Transit Gateway ID"
}

variable "static_routes" {
  type        = list(object({
    blackhole = string
    destination_cidr_block    = string
  }))
  default = []
  description = "List of subnets with labels"
}

variable "route_table_association" {
  type        = bool
  default     = true
  description = "Indicates whether you want to  associate vpc with a route table"
}
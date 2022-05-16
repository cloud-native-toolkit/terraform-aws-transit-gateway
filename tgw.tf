locals {
  transit_gateway_id = var.existing_transit_gateway_id != null && var.existing_transit_gateway_id != "" ? var.existing_transit_gateway_id : (
    var.create_transit_gateway ? aws_ec2_transit_gateway.default[0].id : null
  )
  transit_gateway_route_table_id = var.existing_transit_gateway_route_table_id != null && var.existing_transit_gateway_route_table_id != "" ? var.existing_transit_gateway_route_table_id : (
    var.create_transit_gateway_route_table ? aws_ec2_transit_gateway_route_table.default[0].id : null
  )

  resource_group_name = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  name_prefix     = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  name_gateway        = (var.name_gateway != "" && var.name_gateway != null) ? var.name_gateway : "${local.name_prefix}-transit-gateway"

  lookup_transit_gateway = var.create_transit_gateway
  

    map = [
       {
      vpc_id                            = var.vpc_id
      vpc_cidr                          = var.internal_cidr
      subnet_ids                        = var.subnet_priv_ids
      subnet_route_table_ids            = var.route_table_priv_ids
      route_to_cidr_blocks              = var.route_to_cidr_blocks
      transit_gateway_vpc_attachment_id = null
      number_subnet_route               = var.number_subnet_route
      static_routes = var.static_routes
      # static_routes = [
      #   {
      #     blackhole              = false
      #     destination_cidr_block = "0.0.0.0/0"
      #   }
      # ]
    }

    ]
}

resource "aws_ec2_transit_gateway" "default" {
  count                           = var.create_transit_gateway ? 1 : 0
  description                     = var.transit_gateway_description
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  tags =   {
    Name          = local.name_gateway
    ResourceGroup = local.resource_group_name
    Service       = "transit-gateway"
  }
}

resource "aws_ec2_transit_gateway_route_table" "default" {
  count              = var.create_transit_gateway_route_table ? 1 : 0
  transit_gateway_id = local.transit_gateway_id
  tags =   {
    Name          = "${local.name_gateway}-route_table"
    ResourceGroup = local.resource_group_name
    Service       = "transit-gateway"
  }
}

# Need to find out if VPC is in same account as Transit Gateway.
# See resource "aws_ec2_transit_gateway_vpc_attachment" below.
data "aws_ec2_transit_gateway" "this" {
  count = local.lookup_transit_gateway ? 1 : 0
  id    = local.transit_gateway_id
}

data "aws_vpc" "default" {
  # for_each = var.create_transit_gateway_vpc_attachment && tolist(local.map) != null ? tolist(local.map) : []
  count = length(local.map)
  # id       = each.value["vpc_id"]
  id = local.map[count.index]["vpc_id"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "default" {
  # for_each               = var.create_transit_gateway_vpc_attachment && tolist(local.map) != null ? tolist(local.map) : []
  count = var.tgw_route_table_association ? length(local.map) : 0
  transit_gateway_id     = local.transit_gateway_id
  vpc_id                 = local.map[count.index]["vpc_id"]
  subnet_ids             = local.map[count.index]["subnet_ids"]
  appliance_mode_support = var.vpc_attachment_appliance_mode_support
  dns_support            = var.vpc_attachment_dns_support
  ipv6_support           = var.vpc_attachment_ipv6_support
  tags =   {
    Name          = "${local.name_gateway}-vpc-attechment"
    ResourceGroup = local.resource_group_name
    Service       = "transit-gateway"
  }

  # transit_gateway_default_route_table_association and transit_gateway_default_route_table_propagation
  # must be set to `false` if the VPC is in the same account as the Transit Gateway, and `null` otherwise
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}

# Allow traffic from the VPC attachments to the Transit Gateway
resource "aws_ec2_transit_gateway_route_table_association" "default" {
  # for_each                       = var.create_transit_gateway_route_table_association_and_propagation && tolist(local.map) != null ? tolist(local.map) : []
  count = var.tgw_route_table_association ? length(local.map) : 0
  transit_gateway_attachment_id  = local.map[count.index]["transit_gateway_vpc_attachment_id"] != null ? local.map[count.index]["transit_gateway_vpc_attachment_id"] : aws_ec2_transit_gateway_vpc_attachment.default[count.index]["id"]
  transit_gateway_route_table_id = local.transit_gateway_route_table_id
}

# Allow traffic from the Transit Gateway to the VPC attachments

resource "aws_ec2_transit_gateway_route_table_propagation" "default" {
  # for_each                       = var.create_transit_gateway_route_table_association_and_propagation && tolist(local.map) != null ? tolist(local.map) : []
  count = var.tgw_route_table_association ? length(local.map) : 0
  transit_gateway_attachment_id  = local.map[count.index]["transit_gateway_vpc_attachment_id"] != null ? local.map[count.index]["transit_gateway_vpc_attachment_id"] : aws_ec2_transit_gateway_vpc_attachment.default[count.index]["id"]
  transit_gateway_route_table_id = local.transit_gateway_route_table_id
}

# Static Transit Gateway routes

module "transit_gateway_route" {
  source                         = "./route-tg"
  # for_each                       = var.create_transit_gateway_route_table_association_and_propagation && tolist(local.map) != null ? tolist(local.map) : []
  count = (var.tgw_route_table_association && length(local.map) > 0 ) ? length(local.map) : 0
  transit_gateway_attachment_id  = local.map[count.index]["transit_gateway_vpc_attachment_id"] != null ? local.map[count.index]["transit_gateway_vpc_attachment_id"] : aws_ec2_transit_gateway_vpc_attachment.default[count.index]["id"]
  transit_gateway_route_table_id = local.transit_gateway_route_table_id
  route_config                   = local.map[count.index]["static_routes"] != null ? local.map[count.index]["static_routes"] : []

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.default, aws_ec2_transit_gateway_route_table.default]
}

# Create routes in the subnets' route tables to route traffic from subnets to the Transit Gateway VPC attachments
# Only route to VPCs of the environments defined in `route_to` attribute
module "subnet_route" {
  source                  = "./route-subnet"
  # for_each                = var.create_transit_gateway_vpc_attachment && tolist(local.map) != null ? tolist(local.map) : []a
  count = length(local.map)
  transit_gateway_id      = local.transit_gateway_id
  route_table_ids         = local.map[count.index]["subnet_route_table_ids"] != null ? local.map[count.index]["subnet_route_table_ids"] : []
  destination_cidr_blocks = local.map[count.index]["route_to_cidr_blocks"] != null ? local.map[count.index]["route_to_cidr_blocks"] : []
  number_subnet_route    = local.map[count.index]["number_subnet_route"]
    # route_keys_enabled      = var.route_keys_enabled

  depends_on = [aws_ec2_transit_gateway.default, data.aws_ec2_transit_gateway.this, aws_ec2_transit_gateway_vpc_attachment.default]
}
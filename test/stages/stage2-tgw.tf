# locals {
#   transit_gateway_config = {
#     edge = {
#       vpc_id                            = module.dev_vpc.vpc_id
#       vpc_cidr                          = var.internal_cidr
#       subnet_ids                        = module.edge_priv_subnet_ec2.subnet_ids
#       subnet_route_table_ids            = module.edge_pub_subnet_ec2.route_table_ids
#       route_to_cidr_blocks              = [var.internal_cidr_menage, var.internal_cidr_work]
#       transit_gateway_vpc_attachment_id = null
#       number_subnet_route = var.number_subnet_route_edge
#       static_routes = [
#         {
#           blackhole              = false
#           destination_cidr_block = "0.0.0.0/0"
#         }
#       ]
#     },

#     menage = {
#       vpc_id                            = module.menage_vpc.vpc_id
#       vpc_cidr                          = var.internal_cidr_menage
#       subnet_ids                        = module.menage_priv_subnet_rosa.subnet_ids
#       subnet_route_table_ids            = module.menage_priv_subnet_rosa.route_table_ids
#       route_to_cidr_blocks              = [var.internal_cidr, var.internal_cidr_work, "0.0.0.0/0"]
#       transit_gateway_vpc_attachment_id = null
#       static_routes = null
#       number_subnet_route = var.number_subnet_route_menage
#     },

#     work = {
#       vpc_id                            = module.work_vpc.vpc_id
#       vpc_cidr                          = var.internal_cidr_work
#       subnet_ids                        = module.work_priv_subnet_rosa.subnet_ids
#       subnet_route_table_ids            = module.work_priv_subnet_rosa.route_table_ids
#       route_to_cidr_blocks              = [var.internal_cidr, var.internal_cidr_menage, "0.0.0.0/0"]
#       transit_gateway_vpc_attachment_id = null
#       static_routes                     = null
#       number_subnet_route = var.number_subnet_route_work
#     }
    
#   }
# }

module "menage_aws_tgw" {
  source = "./module"
  depends_on                  = [module.menage_priv_subnet_rosa, module.work_priv_subnet_rosa, module.edge_pub_subnet_ec2]
  vpc_id                      = module.dev_vpc.vpc_id
  subnet_priv_ids             = module.edge_priv_subnet_ec2.subnet_ids
  route_table_priv_ids        = module.edge_priv_subnet_ec2.route_table_ids
  route_to_cidr_blocks        = var.route_to_cidr_blocks
  resource_group_name         = var.resource_group_name
  name_prefix                 = var.name_prefix
}
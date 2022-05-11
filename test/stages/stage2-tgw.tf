module "edge_aws_tgw" {
  source = "./module"
  depends_on                  = [module.menage_priv_subnet_rosa, module.work_priv_subnet_rosa, module.edge_pub_subnet_ec2]
  vpc_id                      = module.dev_vpc.vpc_id
  subnet_priv_ids             = module.edge_priv_subnet_ec2.subnet_ids
  route_table_priv_ids        = module.edge_priv_subnet_ec2.route_table_ids
  route_to_cidr_blocks        = var.route_to_cidr_blocks
  resource_group_name         = var.resource_group_name
  name_prefix                 = var.name_prefix
  static_routes = [ {
            blackhole              = false
           destination_cidr_block = "0.0.0.0/0"
         } ]
}
module "menage_aws_tgw" {
  source = "./module"
  depends_on                  = [module.menage_priv_subnet_rosa, module.work_priv_subnet_rosa, module.edge_pub_subnet_ec2]
  vpc_id                      = module.menage_vpc.vpc_id
  subnet_priv_ids             = module.menage_priv_subnet_rosa.subnet_ids
  route_table_priv_ids        = module.menage_priv_subnet_rosa.route_table_ids
  route_to_cidr_blocks        = var.route_to_cidr_blocks_menage
  resource_group_name         = var.resource_group_name
  name_prefix                 = var.name_prefix_menage
  existing_transit_gateway_id = module.edge_aws_tgw.transit_gateway_id
  existing_transit_gateway_route_table_id = module.edge_aws_tgw.transit_gateway_route_table_id
  number_subnet_route = 9
  create_transit_gateway = false
  create_transit_gateway_route_table = false

}

module "work_aws_tgw" {
  source = "./module"
  depends_on                  = [module.menage_priv_subnet_rosa, module.work_priv_subnet_rosa, module.edge_pub_subnet_ec2]
  vpc_id                      = module.work_vpc.vpc_id
  subnet_priv_ids             = module.work_priv_subnet_rosa.subnet_ids
  route_table_priv_ids        = module.work_priv_subnet_rosa.route_table_ids
  route_to_cidr_blocks        = var.route_to_cidr_blocks_work
  resource_group_name         = var.resource_group_name
  name_prefix                 = var.name_prefix_work
  existing_transit_gateway_id = module.edge_aws_tgw.transit_gateway_id
  existing_transit_gateway_route_table_id = module.edge_aws_tgw.transit_gateway_route_table_id
  number_subnet_route = 9
  create_transit_gateway_route_table = false
  create_transit_gateway = false
}
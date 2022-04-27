module "edge_pub_subnet_ec2" {
  source              = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  provision           = var.provision
  name_prefix         = var.name_prefix
  label               = "public"
  vpc_name            = module.dev_vpc.vpc_name
  subnet_cidrs        = var.pub_subnet_cidrs_edge
  availability_zones  = var.availability_zones
  gateways            = [module.dev_igw.igw_id]
  acl_rules           = var.acl_rules_pub
  resource_group_name = "rg_ec2"
}

module "dev_ngw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-nat-gateway"
  #  _count              = var.cloud_provider == "aws" ? var.gateways_count : 0
  _count              = 3
  provision           = var.provision
  resource_group_name = var.resource_group_name
  name_prefix         = var.name_prefix
  connectivity_type   = "public"
  subnet_ids          = module.edge_pub_subnet_ec2.subnet_ids
}


module "edge_priv_subnet_ec2" {
  source              = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  provision           = var.provision
  name_prefix         = var.name_prefix
  label               = "private"
  vpc_name            = module.dev_vpc.vpc_name
  subnet_cidrs        = var.priv_subnet_cidrs_edge
  availability_zones  = var.availability_zones
  acl_rules           = var.acl_rules_pri
  gateways            = module.dev_ngw.ngw_id
  resource_group_name = "rg_ec2"
}

module "menage_priv_subnet_rosa" {
  source             = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  provision          = var.provision
  name_prefix        = var.name_prefix_menage
  label              = "private_tgw"
  vpc_name           = module.menage_vpc.vpc_name
  subnet_cidrs       = var.priv_subnet_cidrs_menage
  availability_zones = var.availability_zones
  acl_rules          = var.acl_rules_pri
  //gateways            = 
  resource_group_name = "rg_ec2inst"
}

module "work_priv_subnet_rosa" {
  source             = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  provision          = var.provision
  name_prefix        = var.name_prefix_work
  label              = "private"
  vpc_name           = module.work_vpc.vpc_name
  subnet_cidrs       = var.priv_subnet_cidrs_work
  availability_zones = var.availability_zones
  acl_rules          = var.acl_rules_pri
  //gateways            = module.dev_ngw.ngw_id
  resource_group_name = "rg_ec2inst"
}


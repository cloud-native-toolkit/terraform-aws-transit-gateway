module "dev_vpc" {
  source               = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision            = var.provision && var.cloud_provider == "aws" ? true : false
  name_prefix          = var.name_prefix
  internal_cidr        = var.internal_cidr
  instance_tenancy     = var.instance_tenancy
  resource_group_name  = var.resource_group_name
  enable_dns_hostnames = true

}

module "work_vpc" {
  source               = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision            = var.provision && var.cloud_provider == "aws" ? true : false
  name_prefix          = var.name_prefix_work
  internal_cidr        = var.internal_cidr_work
  instance_tenancy     = var.instance_tenancy
  resource_group_name  = var.resource_group_name
  enable_dns_hostnames = true
  # number_subnets_vpn   = length(var.priv_subnet_cidrs_edge)
  # vpn_endpoint_id      = module.dev_vpn.vpn_endpoint_id
  # vpn_subnets_id       = module.edge_priv_subnet_ec2.subnet_ids

}

module "menage_vpc" {
  source               = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision            = var.provision && var.cloud_provider == "aws" ? true : false
  name_prefix          = var.name_prefix_menage
  internal_cidr        = var.internal_cidr_menage
  instance_tenancy     = var.instance_tenancy
  resource_group_name  = var.resource_group_name
  enable_dns_hostnames = true
  # number_subnets_vpn   = length(var.priv_subnet_cidrs_edge)
  # vpn_endpoint_id      = module.dev_vpn.vpn_endpoint_id
  # vpn_subnets_id       = module.edge_priv_subnet_ec2.subnet_ids

}

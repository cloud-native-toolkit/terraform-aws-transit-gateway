variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Please set the region where the resouces to be created "
}

variable "cloud_provider" {
  type = string
  default = "aws"
}

variable "availability_zones" {
  description = "List of availability zone ids"
  type        = list(string)
  default     = []
}

variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "rosa_token" {
  type        = string
  default     = ""
  description = ""
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group where the IKS cluster will be provisioned."
  default     = "default"
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe"
}

variable "name_prefix_menage" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe"
}

variable "name_prefix_work" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe"
}




# variable "prefix_name" {
#   type        = string
#   description = "Prefix to be added to the names of resources which are being provisioned"
#   default     = "swe"
# }
variable "label" {
  default = "prd"
  type    = string
}
variable "provision" {
  type        = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default     = true
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "Name of the RedHat OpenShift Cluster"
}
variable "cluster_name_menage" {
  type        = string
  default     = ""
  description = "Name of the RedHat OpenShift Cluster"
}

variable "cluster_name_work" {
  type        = string
  default     = ""
  description = "Name of the RedHat OpenShift Cluster"
}

variable "ocp_version" {
  type        = string
  default     = "4.9.15"
  description = "Version of OpenShift that will be used to install the cluster"
}

variable "no_of_compute_nodes" {
  type        = number
  default     = 2
  description = "Number of worker nodes to be provisioned"
}


variable "compute-machine-type" {
  type        = string
  default     = ""
  description = "Instance type for the compute nodes. Determines the amount of memory and vCPU allocated to each compute node."
}

variable "machine-cidr" {
  type        = string
  default     = ""
  description = "ipNet Block of IP addresses used by OpenShift while installing the cluster, for example 10.0.0.0/16 "
}
variable "machine-cidr_menage" {
  type        = string
  default     = ""
  description = "ipNet Block of IP addresses used by OpenShift while installing the cluster, for example 10.0.0.0/16 "
}

variable "machine-cidr_work" {
  type        = string
  default     = ""
  description = "ipNet Block of IP addresses used by OpenShift while installing the cluster, for example 10.0.0.0/16 "
}
variable "service-cidr" {
  type        = string
  default     = ""
  description = "ipNet Block of IP addresses for services, for example 172.30.0.0/16 "
}

variable "pod-cidr" {
  type        = string
  default     = ""
  description = "ipNet Block of IP addresses from which Pod IP addresses are allocated, for example 10.128.0.0/14 "
}
variable "host-prefix" {
  type        = number
  default     = 23
  description = "Subnet prefix length to assign to each individual node. For example, if host prefix is set to 23, then each node is assigned a /23 subnet out of the given CIDR."
}
variable "etcd-encryption" {
  type        = string
  default     = ""
  description = "Add etcd encryption. By default etcd data is encrypted at rest. This option configures etcd encryption on top of existing storage encryption."
}


variable "multi-zone-cluster" {
  type = bool
  default = false
  description = " Deploy to multiple data centers"
}

variable "gateways_count" {
  type = number
  default = 1
  description = "Number of NAT gateways"
}


 variable "private-link" {
   type = bool
   default = "true"
   description = "Provides private connectivity between VPCs, AWS services, and your on-premises networks, without exposing your traffic to the public internet"
 }


variable "existing_vpc" {
  type        = bool
  default     = true
  description = "Flag to identify if VPC already exists. Default set to true. Used to identify to pass the subnet ids to create the ROSA cluster"
}

variable "vpn_subnets_id" {
  type        = list(string)
  description = "id of associated subnets with vpn client service"
  default     = []
}

variable "client_cidr_block" {
   type = string
   description = "client cidr block"
   default = ""
}
variable "number_subnets_vpn" {
   description = "list if subnets to attch with vpn"
   type = number
   default = 0
}
variable "vpn_endpoint_id" {
  type        = string
  description = "The vpn client endpoint."
  default     = ""
}

variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "To create cluster in existing VPC, public and private Subnet ids should be given ."
  default     = [""]
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "To create cluster in existing VPC, public and private Subnet ids should be given ."
  default     = [""]
}

variable "dry_run" {
  type        = bool
  description = "Set to true to dry the command just to verify. Else set to false to actually run the cmd"
  default     = true
}



variable "pub_subnet_cidrs_edge" {
  type        = list(string)
  description = "The cidr range of the Public subnet."
  #default=["10.0.0.0/20"]
}

variable "pub_subnet_cidrs_work" {
  type        = list(string)
  description = "The cidr range of the Public subnet."
  #default=["10.0.0.0/20"]
}

variable "pub_subnet_cidrs_menage" {
  type        = list(string)
  description = "The cidr range of the Public subnet."
  #default=["10.0.0.0/20"]
}


variable "priv_subnet_cidrs_edge" {
  type        = list(string)
  description = "The cidr range of the Private subnet."
  #default=["10.0.128.0/20"]
}

variable "priv_subnet_cidrs_work" {
  type        = list(string)
  description = "The cidr range of the Private subnet."
  #default=["10.0.128.0/20"]
}
variable "priv_subnet_cidrs_menage" {
  type        = list(string)
  description = "The cidr range of the Private subnet."
  #default=["10.0.128.0/20"]
}

variable "availability_zones_menage" {
  description = "List of availability zone ids"
  type        = list(string)
  default     = []
}
variable "acl_rules_pub" {
  type        = list(map(string))
  default = []
}
variable "acl_rules_pri" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))
  default = []
}

variable "connectivity_type" {
  type        = string
  description = "(Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public."
  default     = "public"    
}
variable "key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"
}
variable "rotation_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled."
}

variable "kms_alias" {
  type        = string
  default     = "Storage-kms"
  description = "The description of the key alias as viewed in AWS console."
}

variable "alias" {
  type        = string
  default     = "Storage-kms"
  description = "The display name of the key."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the key is enabled."
}
variable "instance_tenancy" {
  type        = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default     = "default"
}
variable "internal_cidr" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = "10.0.0.0/16"
}

variable "internal_cidr_menage" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = ""
}

variable "internal_cidr_work" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = ""
}

variable "allowed_cidr_ranges" {
  description = "List of alloud cider in vpn"
  type        = list(string)
  default     = []
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS Servers for vpn"
}

variable "private_key_file" {
  type    = string
  default = ""
}

variable "private_key" {
  type    = string
  default = ""
}

variable "public_key_file" {
  type    = string
  default = ""
}

variable "rsa_bits" {
  type    = number
  default = 3072
}

variable "num_of_private_subnets_rosa" {
  type = number
}

variable "root_volume_type" {
  type        = string
  description = "Type of root volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "prefix_name" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "swe-advance"
}
variable "publickey" {
  type        = string
  default     = ""
  description = "EC2 Instance Public Key"
}
variable "root_block_device_encrypted" {
  type        = bool
  default     = true
  description = "Whether to encrypt the root block device"
}
variable "client_cidr" {
  type        = string
  default     = ""
  description = "VPN client side CIDR"
}
variable "root_volume_size" {
  type        = number
  description = "Size of the root volume in gigabytes"
  default     = 10
}
variable "pri_instance_monitoring" {
  type        = bool
  default     = false
  description = "Enable  EC2 private instance advance monitoring"
}

variable "name" {
  type    = string
  default = "vpn_rosa"
}
variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t3.large"
}
variable "ami_id" {
  type        = string
  description = "AMI ID for bastion host"
  default     = "ami-03fa4afc89e4a8a09"
  #  default = "ami-0573b70afecda915d"
}

variable "public_key" {
  type    = string
  default = ""
}

#tgw-----veiyable

variable "auto_accept_shared_attachments" {
  type        = string
  default     = "enable"
  description = "Whether resource attachment requests are automatically accepted. Valid values: `disable`, `enable`. Default value: `disable`"
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

variable "config" {
  type = map(object({
    vpc_id                            = string
    vpc_cidr                          = string
    subnet_ids                        = set(string)
    subnet_route_table_ids            = set(string)
    route_to_cidr_blocks              = set(string)
    transit_gateway_vpc_attachment_id = string
    number_subnet_route = number
    static_routes = set(object({
      blackhole              = bool
      destination_cidr_block = string
    }))
  }))

  description = "Configuration for VPC attachments, Transit Gateway routes, and subnet routes"
  default     = null
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

variable "create_transit_gateway" {
  type        = bool
  default     = true
  description = "Whether to create a Transit Gateway. If set to `false`, an existing Transit Gateway ID must be provided in the variable `existing_transit_gateway_id`"
}

variable "create_transit_gateway_route_table" {
  type        = bool
  default     = true
  description = "Whether to create a Transit Gateway Route Table. If set to `false`, an existing Transit Gateway Route Table ID must be provided in the variable `existing_transit_gateway_route_table_id`"
}

variable "create_transit_gateway_vpc_attachment" {
  type        = bool
  default     = true
  description = "Whether to create Transit Gateway VPC Attachments"
}

variable "create_transit_gateway_route_table_association_and_propagation" {
  type        = bool
  default     = true
  description = "Whether to create Transit Gateway Route Table associations and propagations"
}

variable "route_keys_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    If true, Terraform will use keys to label routes, preventing unnecessary changes,
    but this requires that the VPCs and subnets already exist before using this module.
    If false, Terraform will use numbers to label routes, and a single change may
    cascade to a long list of changes because the index or order has changed, but
    this will work when the `true` setting generates the error `The "for_each" value depends on resource attributes...`
    EOT
}

#--route_subnet_transit gateway-----
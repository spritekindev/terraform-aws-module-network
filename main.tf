data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = var.name
  cidr = var.vpc_cidr_block

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  database_subnets = var.database_subnets

  enable_vpn_gateway = false

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  reuse_nat_ips = var.reuse_nat_ips
  external_nat_ip_ids = var.external_nat_ip_ids

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Network = var.name
  }

  # Pretag all resources to make them ready for kubernetes
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared",
    "kubernetes.io/role/elb"    = "true"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared",
    "kubernetes.io/role/internal-elb"    = "true"
  }

}


module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id

  endpoints = {
    s3 = {
      service = "s3"
      tags    = { Name = "s3-vpc-endpoint" }
    }
  }

  tags = {
    Company  = var.company
    Endpoint = "true"
  }
}
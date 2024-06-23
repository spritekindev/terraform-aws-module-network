module "vpc_peering" {
  count = var.ingress_vpc_id == "" ? 0 : 1

  source  = "./vpc-peering"
  providers = {
    aws.ingress = aws.ingress
  }

  vpc_id = module.vpc.vpc_id
  vpc_owner_id = module.vpc.vpc_owner_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  private_route_table_ids = {for i, val in module.vpc.private_route_table_ids: i => val}
  public_route_table_ids = {for i, val in module.vpc.public_route_table_ids: i => val}

  ingress_vpc_id = var.ingress_vpc_id
  ingress_cidr_block = var.ingress_cidr_block
  ingress_private_route_table_id = var.ingress_private_route_table_id
  ingress_public_route_table_id = var.ingress_public_route_table_id

}

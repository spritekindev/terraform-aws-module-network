# Test script

# Region specific providers
provider "aws" {
  alias  = "test"
  region = "ap-southeast-2"
}

module "test" {
  source  = "./.."
  providers = {
    aws = aws.test
    aws.ingress = aws.test
  }

  vpc_id = "dummy"
  vpc_owner_id = "dummy"
  vpc_cidr_block = "dummy"
  private_route_table_ids = {one="dummy1",two="dummy2",three="dummy3"}
  public_route_table_ids = {one="dummy1",two="dummy2",three="dummy3"}

  ingress_vpc_id = "dummy"
  ingress_cidr_block = "dummy"
  ingress_private_route_table_id = "dummy"
  ingress_public_route_table_id = "dummy"
}

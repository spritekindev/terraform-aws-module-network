#################################################################################
# This version of the vpc pering allows connecting one RTB from the ingress to 
#  many RTB in the target VPC
#################################################################################

#################################################################################
# Current region
data "aws_region" "current" {}

#################################################################################
### Connect from source to target, this object is created in the ingress VPC
resource "aws_vpc_peering_connection" "ingress" {
  vpc_id        = var.ingress_vpc_id
  peer_vpc_id   = var.vpc_id
  peer_owner_id = var.vpc_owner_id
  peer_region   = data.aws_region.current.name
  auto_accept   = false
  tags = {
    Name = var.vpc_peering_name
    Side = "Requester"
  }
  provider      = aws.ingress
}

# The target VPC accepts the connection from the ingress vpc
resource "aws_vpc_peering_connection_accepter" "ingress" {
  vpc_peering_connection_id = aws_vpc_peering_connection.ingress.id
  auto_accept               = true
  tags = {
    Name = var.vpc_peering_name
    Side = "Accepter"
  }
}

#################################################################################
# Register routes from ingress to target and target to the ingress
# Note routing does not mean access. It just knows where to send the messages.
# Access can be restricted by security groups

## Allow the private network in the ingress vpc to route to the target vpc
resource "aws_route" "private_ingress_to_this" {
  route_table_id            = var.ingress_private_route_table_id
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ingress.id
  provider                  = aws.ingress
}

## Allow the public network in the ingress VPC to route to the public network in this VPC
resource "aws_route" "public_ingress_to_this" {
  route_table_id            = var.ingress_public_route_table_id
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ingress.id
  provider                  = aws.ingress
}

## Allow the private network in this VPC to route to the ingress VPC
resource "aws_route" "private_this_to_ingress" {
  for_each = var.private_route_table_ids
  route_table_id            = each.value
  destination_cidr_block    = var.ingress_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ingress.id
}

## Allow the public network in the target VPC to route to the ingress VPC
resource "aws_route" "public_au_dev_to_au_support" {
  for_each = var.public_route_table_ids
  route_table_id            = each.value
  destination_cidr_block    = var.ingress_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ingress.id
}

###################################################################################
# Information for the VPC that will be set as the connection target
# References are managed by the default aws provider
variable "vpc_peering_name" {
  type = string
  description = "A name that will be assigned to the peering connection."
  default = "CreatedByTerraformCloud"
}

variable "vpc_id" {
  type = string
  description = "A VPC that is the connection target. Uses the aws provider."
}

variable "vpc_owner_id" {
  type = string
  description = "The target VPC owner. Uses the aws provider."
}

variable "vpc_cidr_block" {
  type = string
  description = "The CIDR block of the ingress VPC."
}

variable "private_route_table_ids" {
  type = map(string)
  description = "A map of route table for the private network."
}

variable "public_route_table_ids" {
  type = map(string)
  description = "The list of route tables of the public network."
}

###################################################################################
# Information for the VPC that will be set as the connection source
# References are managed by the aws.ingress provider
variable "ingress_vpc_id" {
  type = string
  description = "A VPC that will be allowed to connect into this VPC. Requires the aws.ingress provider to be set."
}

variable "ingress_cidr_block" {
  type = string
  description = "The CIDR block of the ingress VPC. Requires the aws.ingress provider to be set."
}

variable "ingress_private_route_table_id" {
  type = string
  description = "The route table of the private network of the ingress id. Requires the aws.ingress provider to be set."
}

variable "ingress_public_route_table_id" {
  type = string
  description = "The route table of the public network of the ingress id. Requires the aws.ingress provider to be set."
}

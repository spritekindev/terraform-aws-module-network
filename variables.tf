variable "project" {
  type = string
  description = "The project the network belongs to."
}

variable "name" {
  type = string
  description = "Name of the network."
}

variable "azs" {
  type = list(string)
  description = "Which AZs to use for the VPC"
}

variable "vpc_cidr_block" {
  type = string
  description = "Full CIDR block to use for the VPC"
}

variable "public_subnets" {
  type = list(string)
  description = "List of CIDR blocks to use for public subnets"
}

variable "private_subnets" {
  type = list(string)
  description = "List of CIDR blocks to use for private subnets"
}

variable "database_subnets" {
  type = list(string)
  default = []
  description = "List of CIDR blocks to use for database subnets"
}

variable "enable_nat_gateway" {
  type = bool
  default = true
  description = "Create a NAT gateway by default. Set to false to not create a NAT gateway at all."
}

variable "single_nat_gateway" {
  type = bool
  default = true
  description = "Create one single NAT gateway."
}

variable "one_nat_gateway_per_az" {
  type = bool
  default = false
  description = "Create"
}

# Elastic IP to use for
variable "reuse_nat_ips" {
  type = bool
  default = false
  description = "Make true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids'"
}

variable "external_nat_ip_ids" {
  type = list(string)
  default = []
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
}

variable "ingress_vpc_id" {
  type = string
  default = ""
  description = "A VPC that will be allowed to connect into this VPC. Requires the aws.ingress provider to be set."
}

variable "ingress_cidr_block" {
  type = string
  default = ""
  description = "The CIDR block of the ingress VPC. Requires the aws.ingress provider to be set."
}

variable "ingress_private_route_table_id" {
  type = string
  default = ""
  description = "The route table of the private network of the ingress id. Requires the aws.ingress provider to be set."
}

variable "ingress_public_route_table_id" {
  type = string
  default = ""
  description = "The route table of the public network of the ingress id. Requires the aws.ingress provider to be set."
}

variable "activity_log_bucket" {
  type = string
  description = "The bucket name this foundation will use as activity log target. Should be in the same account and configured as log target."
}

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

  project           = "dummy"
  name              = "dummy"
  azs               = ["dummy"]
  vpc_cidr_block    = "0.0.0.0/0"
  public_subnets    = ["dummya", "dummyb"]
  private_subnets   = ["dummya", "dummyb"]
  activity_log_bucket = "dummy"
  database_subnets   = ["dummya", "dummyb"]
}

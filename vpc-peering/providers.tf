terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.10.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.30.0"
      configuration_aliases = [ aws.ingress ]
    }
  }
  required_version = ">= 1.0"
}

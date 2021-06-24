terraform {
  required_version = ">= 0.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
      configuration_aliases = [
        aws.admin
      ]
    }
  }
}

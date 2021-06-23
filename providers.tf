provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.firewall_manager_administrator_arn
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "variable_arn"
  assume_role {
    role_arn = local.assumed_arn
  }
}

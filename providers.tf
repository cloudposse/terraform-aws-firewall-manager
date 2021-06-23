provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.firewall_manager_administrator_arn
  }
}

provider "aws" {
  region = var.region
  alias  = "variable_arn"
  assume_role {
    role_arn = local.assumed_arn
  }
}

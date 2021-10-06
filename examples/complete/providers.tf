provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.firewall_manager_administrator_role_arn
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = local.assume_role_arn
  }
  # assumes role of Firewall manager or Root account based on TF apply / destroy. (Bug with AWS API)
  alias = "admin"
}


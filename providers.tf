provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.assume_arn
  }
}

provider "aws" {
  alias  = "firewall_manager_admin"
  region = var.region
  assume_role {
    role_arn = var.firewall_manager_administrator_arn
  }
}

provider "aws" {
  alias  = "organization_management"
  region = var.region
  assume_role {
    role_arn = var.organization_management_arn
  }
}

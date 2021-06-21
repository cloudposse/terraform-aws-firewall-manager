provider "aws" {
  region = var.region
    assume_role {
      role_arn = var.assume_arn
    }
}

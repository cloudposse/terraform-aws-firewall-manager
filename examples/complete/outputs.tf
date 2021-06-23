output "admin_account_id" {
  description = "The AWS account ID of the AWS Firewall Manager administrator account."
  value       = module.fms.admin_account_id
}

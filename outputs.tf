output "admin_account_id" {
  description = "The AWS account ID of the AWS Firewall Manager administrator account."
  value       = join("", aws_fms_admin_account.default.*.id)
}

//output "admin_account_id" {
//  description = "The AWS account ID of the AWS Firewall Manager administrator account."
//  value       = join("", aws_fms_admin_account.default.*.id)
//}

output "aws_fms_account" {
  value = aws_fms_admin_account.default
}

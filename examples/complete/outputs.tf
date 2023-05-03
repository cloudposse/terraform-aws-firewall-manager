# Account numbers are sensitive, do not include them in test output

output "admin_account_id_length" {
  value       = try(length(module.firewall_manager.admin_account), 0)
  description = "Length of AWS Account ID of the designated admin account."
}

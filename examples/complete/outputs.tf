output "firewall_manager_admin_account_id" {
  value       = module.firewall_manager.admin_account.id
  description = "AWS Account ID of the designated admin account."
}

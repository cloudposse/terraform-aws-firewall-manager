output "firewall_manager_admin_account" {
  value       = module.firewall_manager.admin_account
  description = "AWS Account ID of the designated admin account."
}

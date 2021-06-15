variable "admin_account_id" {
  type        = string
  description = "The AWS account ID to associate with AWS Firewall Manager as the AWS Firewall Manager administrator account. This can be an AWS Organizations master account or a member account. Defaults to the current account."
  default     = null
}

variable "security_groups_common_policies" {
  type    = list(any)
  default = []
}

variable "security_groups_content_audit_policies" {
  type    = list(any)
  default = []
}

variable "security_groups_usage_audit_policies" {
  type    = list(any)
  default = []
}

variable "shiled_advanced_policies" {
  type    = list(any)
  default = []
}

variable "waf_policies" {
  type    = list(any)
  default = []
}

variable "waf_v2_policies" {
  type    = list(any)
  default = []
}

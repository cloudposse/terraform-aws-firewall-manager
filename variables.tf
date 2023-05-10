variable "admin_account_id" {
  type        = string
  description = "The AWS account ID to associate to associate with AWS Firewall Manager as the AWS Firewall Manager administrator account. This can be an AWS Organizations master account or a member account. Defaults to the current account."
  default     = null
}

variable "admin_account_enabled" {
  type        = bool
  description = "Resource for aws_fms_admin_account is enabled and will be created or destroyed"
  default     = true
}

variable "firehose_enabled" {
  type        = bool
  description = "Create a Kinesis Firehose destination for WAF_V2 Rules. Conflicts with `firehose_arn`"
  default     = false
}

variable "firehose_arn" {
  type        = string
  description = "Kinesis Firehose ARN used to create a Kinesis Firehose destination for WAF_V2 Rules. Conflicts with `firehose_enabled`"
  default     = null
}

variable "security_groups_common_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      revert_manual_security_group_changes:
        Whether to revert manual Security Group changes.
        Defaults to `false`.
      exclusive_resource_security_group_management:
        Wheter to exclusive resource Security Group management.
        Defaults to `false`.
      apply_to_all_ec2_instance_enis:
        Whether to apply to all EC2 instance ENIs.
        Defaults to `false`.
      security_groups:
        A list of Security Group IDs.
  DOC
}

variable "security_groups_content_audit_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      security_group_action:
        For `ALLOW`, all in-scope security group rules must be within the allowed range of the policy's security group rules.
        For `DENY`, all in-scope security group rules must not contain a value or a range that matches a rule value or range in the policy security group.
        Possible values: `ALLOW`, `DENY`.
      security_groups:
        A list of Security Group IDs.
  DOC
}

variable "security_groups_usage_audit_policies" {
  type        = list(any)
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      delete_unused_security_groups:
        Whether to delete unused Security Groups.
        Defaults to `false`.
      coalesce_redundant_security_groups:
        Whether to coalesce redundant Security Groups.
        Defaults to `false`.
  DOC
}

variable "shield_advanced_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data: # Should be used for CloudFront only. (ALBs are not supported yet)
      automaticResponseStatus:
        The default value for automaticResponseStatus is IGNORED
        Possible values: `ENABLED`, `IGNORED`, or `DISABLED`.
      automaticResponseAction:
        The value for automaticResponseAction is only required when automaticResponseStatus is set to ENABLED.
        Possible values: `BLOCK` or `COUNT`.
      overrideCustomerWebaclClassic:
        The default value for overrideCustomerWebaclClassic is false
  DOC
}

variable "waf_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      default_action:
        The action that you want AWS WAF to take.
        Possible values: `ALLOW`, `BLOCK` or `COUNT`.
      rule_groups:
        A list of rule groups.
  DOC
}

variable "waf_v2_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      default_action:
        The action that you want AWS WAF to take.
        Possible values: `ALLOW`, `BLOCK` or `COUNT`.
      override_customer_web_acl_association:
        Wheter to override customer Web ACL association
      logging_configuration:
        The WAFv2 Web ACL logging configuration.
      pre_process_rule_groups:
        A list of pre-proccess rule groups.
      post_process_rule_groups:
        A list of post-proccess rule groups.
  DOC
}

variable "dns_firewall_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      pre_process_rule_groups:
        A list of maps of pre-proccess rule groups in the format `{ "ruleGroupId": "rslvr-frg-1", "priority": 10 }`.
      post_process_rule_groups:
        A list of maps post-proccess rule groups in the format `{ "ruleGroupId": "rslvr-frg-1", "priority": 10 }`.
  DOC
}

variable "network_firewall_policies" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The friendly name of the AWS Firewall Manager Policy.
    delete_all_policy_resources:
      Whether to perform a clean-up process.
      Defaults to `true`.
    exclude_resource_tags:
      A boolean value, if `true` the tags that are specified in the `resource_tags` are not protected by this policy.
      If set to `false` and `resource_tags` are populated, resources that contain tags will be protected by this policy.
      Defaults to `false`.
    remediation_enabled:
      A boolean value, indicates if the policy should automatically applied to resources that already exist in the account.
      Defaults to `false`.
    resource_type_list:
      A list of resource types to protect. Conflicts with `resource_type`.
    resource_type:
      A resource type to protect. Conflicts with `resource_type_list`.
    resource_tags:
      A map of resource tags, that if present will filter protections on resources based on the `exclude_resource_tags`.
    exclude_account_ids:
      A list of AWS Organization member Accounts that you want to exclude from this AWS FMS Policy.
    include_account_ids:
      A list of AWS Organization member Accounts that you want to include for this AWS FMS Policy.
    policy_data:
      stateless_rule_group_references:
        A list of maps of configuration blocks containing references to the stateful rule groups that are used in the policy.
        Format: `{ "resourceARN": "arn:aws:network-firewall:us-west-1:1234567891011:stateless-rulegroup/rulegroup2", "priority": 10 }`
      stateless_default_actions:
        A list of actions to take on a packet if it does not match any of the stateless rules in the policy.
        You must specify one of the standard actions including: `aws:drop`, `aws:pass`, or `aws:forward_to_sfe`.
        In addition, you can specify custom actions that are compatible with your standard action choice.
        If you want non-matching packets to be forwarded for stateful inspection, specify aws:forward_to_sfe.
      stateless_fragment_default_actions:
        A list of actions to take on a fragmented packet if it does not match any of the stateless rules in the policy.
        You must specify one of the standard actions including: `aws:drop`, `aws:pass`, or `aws:forward_to_sfe`.
        In addition, you can specify custom actions that are compatible with your standard action choice.
        If you want non-matching packets to be forwarded for stateful inspection, specify aws:forward_to_sfe.
      stateless_custom_actions:
        A list of maps describing the custom action definitions that are available for use in the firewall policy's `stateless_default_actions`.
        Format: `{ "actionName": "custom1", "actionDefinition": { "publishMetricAction": { "dimensions": [ { "value": "dimension1" } ] } } }`
      stateful_rule_group_references_arns:
        A list of ARNs of the stateful rule groups.
      orchestration_config:
        single_firewall_endpoint_per_vpc:
          Whether to use single Firewall Endpoint per VPC.
          Defaults to `false`.
        allowed_ipv4_cidrs:
          A list of allowed ipv4 cidrs.
  DOC
}

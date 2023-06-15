locals {
  assume_role_arn = var.is_destroy ? var.firewall_manager_administrator_role_arn : var.organization_management_role_arn
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.1.0"

  ipv4_primary_cidr_block = "10.0.0.0/16"

  context = module.this.context
}

module "firewall_manager" {
  source = "../../"

  providers = {
    aws.admin = aws.admin
    aws       = aws
  }

  shield_advanced_policies  = var.shield_advanced_policies
  waf_policies              = var.waf_policies
  dns_firewall_policies     = var.dns_firewall_policies
  network_firewall_policies = var.network_firewall_policies
  firehose_enabled          = var.firehose_enabled
  firehose_arn              = var.firehose_arn

  admin_account_enabled = false
  admin_account_id      = "222222222222"

  security_groups_usage_audit_policies = [
    {
      name               = "unused-sg"
      resource_type_list = ["AWS::EC2::SecurityGroup"]

      policy_data = {
        delete_unused_security_groups      = false
        coalesce_redundant_security_groups = false
      }
    }
  ]

  security_groups_content_audit_policies = [
    {
      name               = "maxmimum-allowed"
      resource_type_list = ["AWS::EC2::SecurityGroup"]

      policy_data = {
        security_group_action = "allow"
        security_groups       = [module.vpc.vpc_default_security_group_id]
      }
    }
  ]

  security_groups_common_policies = [
    {
      name               = "disabled-all"
      resource_type_list = ["AWS::EC2::SecurityGroup"]

      policy_data = {
        revert_manual_security_group_changes         = false
        exclusive_resource_security_group_management = false
        apply_to_all_ec2_instance_enis               = false
        security_groups                              = [module.vpc.vpc_default_security_group_id]
      }
    }
  ]

  waf_v2_policies = [
    {
      name               = "linux-policy"
      resource_type_list = ["AWS::ElasticLoadBalancingV2::LoadBalancer", "AWS::ApiGateway::Stage"]

      policy_data = {
        default_action                        = "allow"
        override_customer_web_acl_association = false
        pre_process_rule_groups = [
          {
            "managedRuleGroupIdentifier" : {
              "vendorName" : "AWS",
              "managedRuleGroupName" : "AWSManagedRulesLinuxRuleSet",
              "version" : null
            },
            "overrideAction" : { "type" : "NONE" },
            "ruleGroupArn" : null,
            "excludeRules" : [],
            "ruleGroupType" : "ManagedRuleGroup"
          }
        ]
      }
    }
  ]

  context = module.this.context
}

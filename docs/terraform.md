<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |
| <a name="provider_aws.firewall_manager_admin"></a> [aws.firewall\_manager\_admin](#provider\_aws.firewall\_manager\_admin) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_firewall_label"></a> [dns\_firewall\_label](#module\_dns\_firewall\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_network_firewall_label"></a> [network\_firewall\_label](#module\_network\_firewall\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_security_groups_common_label"></a> [security\_groups\_common\_label](#module\_security\_groups\_common\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_security_groups_content_audit_label"></a> [security\_groups\_content\_audit\_label](#module\_security\_groups\_content\_audit\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_security_groups_usage_audit_label"></a> [security\_groups\_usage\_audit\_label](#module\_security\_groups\_usage\_audit\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_shiled_advanced_label"></a> [shiled\_advanced\_label](#module\_shiled\_advanced\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |
| <a name="module_waf_label"></a> [waf\_label](#module\_waf\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_waf_v2_label"></a> [waf\_v2\_label](#module\_waf\_v2\_label) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [aws_fms_admin_account.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_admin_account) | resource |
| [aws_fms_policy.dns_firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.network_firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.security_groups_common](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.security_groups_content_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.security_groups_usage_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.shiled_advanced](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.waf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_fms_policy.waf_v2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_policy) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_admin_account_ids"></a> [admin\_account\_ids](#input\_admin\_account\_ids) | A list of AWS account IDs to associate with AWS Firewall Manager as the AWS Firewall Manager administrator account. This can be an AWS Organizations master account or a member account. Defaults to the current account. | `list(string)` | `[]` | no |
| <a name="input_assume_arn"></a> [assume\_arn](#input\_assume\_arn) | The ARN of the role you want to assume for making these changes - must be a root account for setting up Firewall Manager Admin Account. | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_dns_firewall_policies"></a> [dns\_firewall\_policies](#input\_dns\_firewall\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_firewall_manager_administrator_arn"></a> [firewall\_manager\_administrator\_arn](#input\_firewall\_manager\_administrator\_arn) | The ARN of the role you want to assume for destroying these changes - must be the AWS Firewall Manager administrator account. (contains admin\_account\_ids) | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_network_firewall_policies"></a> [network\_firewall\_policies](#input\_network\_firewall\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_organization_management_arn"></a> [organization\_management\_arn](#input\_organization\_management\_arn) | The ARN of the role you want to assume for applying these changes - must be a root account for setting up Firewall Manager Admin Account. | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_security_groups_common_policies"></a> [security\_groups\_common\_policies](#input\_security\_groups\_common\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_security_groups_content_audit_policies"></a> [security\_groups\_content\_audit\_policies](#input\_security\_groups\_content\_audit\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_security_groups_usage_audit_policies"></a> [security\_groups\_usage\_audit\_policies](#input\_security\_groups\_usage\_audit\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_shiled_advanced_policies"></a> [shiled\_advanced\_policies](#input\_shiled\_advanced\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_waf_policies"></a> [waf\_policies](#input\_waf\_policies) | n/a | `list(any)` | `[]` | no |
| <a name="input_waf_v2_policies"></a> [waf\_v2\_policies](#input\_waf\_v2\_policies) | n/a | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_fms_account"></a> [aws\_fms\_account](#output\_aws\_fms\_account) | n/a |
<!-- markdownlint-restore -->

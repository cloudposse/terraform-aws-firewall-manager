module "firehose_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["firehose"]

  context = module.this.context
}

module "firehose_s3_bucket" {
  count                  = local.enabled && var.firehose_enabled ? 1 : 0
  source                 = "cloudposse/s3-bucket/aws"
  version                = "0.44.1"
  acl                    = "private"
  enabled                = true
  user_enabled           = true
  versioning_enabled     = false
  allowed_bucket_actions = ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"]
  name                   = module.firehose_label.id
  stage                  = module.this.stage
  namespace              = module.this.namespace
  bucket_name            = module.firehose_label.id

  context = module.this.context
}

data "aws_iam_policy_document" "assume_role" {
  count = local.enabled ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "firehose_role" {
  count = local.enabled && var.firehose_enabled ? 1 : 0
  name  = module.firehose_label.id

  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  count = local.enabled && var.firehose_enabled ? 1 : 0
  // `aws-waf-logs-` required by AWS - https://aws.amazon.com/premiumsupport/knowledge-center/waf-configure-comprehensive-logging/
  name        = format("%s%s", "aws-waf-logs-", module.this.id)
  destination = "s3"

  s3_configuration {
    role_arn   = join("", aws_iam_role.firehose_role.*.arn)
    bucket_arn = join("", module.firehose_s3_bucket.*.bucket_arn)
  }
}

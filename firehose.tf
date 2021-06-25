module "firehose" {
  source = "cloudposse/label/null"
  version = "0.24.1"

  attributes = ["firehose"]

  context = module.this.context
}

resource "aws_s3_bucket" "firehose_bucket" {
  count       = local.enabled && var.firehose_enabled ? 1 : 0
  bucket      = module.firehose.id
  acl         = "private"
}


resource "aws_iam_role" "firehose_role" {
  count               = local.enabled && var.firehose_enabled ? 1 : 0
  name                = module.firehose.id

  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  count       = local.enabled && var.firehose_enabled ? 1 : 0
  // `aws-waf-logs-` required by AWS - https://aws.amazon.com/premiumsupport/knowledge-center/waf-configure-comprehensive-logging/
  name                = format("%s%s", "aws-waf-logs-", module.this.id)
  destination = "s3"

  s3_configuration {
    role_arn   = join("", aws_iam_role.firehose_role.*.arn)
    bucket_arn = join("", aws_s3_bucket.firehose_bucket.*.arn)
  }
}

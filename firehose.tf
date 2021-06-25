resource "aws_s3_bucket" "firehose_bucket" {
  count       = var.firehose_enabled ? 1 : 0
  bucket      = module.this.id
  acl         = "private"
}

resource "aws_iam_role" "firehose_role" {
  count               = var.firehose_enabled ? 1 : 0
  name                = format("%s_%s", module.this.id, "firehose_aws_fms_role")

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
  count       = var.firehose_enabled ? 1 : 0
  // `aws-waf-logs-` required by AWS - https://aws.amazon.com/premiumsupport/knowledge-center/waf-configure-comprehensive-logging/
  name                = format("%s%s", "aws-waf-logs-", module.this.id)
  destination = "s3"

  s3_configuration {
    role_arn   = join("", aws_iam_role.firehose_role.*.arn)
    bucket_arn = join("", aws_s3_bucket.firehose_bucket.*.arn)
  }
}

terraform {
  backend "s3" {
  }
}
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  required_version = ">= 0.12"
}


data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [local.aws_account_id]
      type        = "AWS"
    }
    actions   = ["*"]
    resources = ["${aws_s3_bucket.test_bucket.arn}/*"]
  }

  statement {
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions   = ["*"]
    resources = ["${aws_s3_bucket.test_bucket.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false",
      ]
    }
  }
}


resource "aws_s3_bucket_policy" "bucket_access_policy" {
  count  = var.with_policy ? 1 : 0
  bucket = aws_s3_bucket.test_bucket.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

data "aws_caller_identity" "current" {
}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}


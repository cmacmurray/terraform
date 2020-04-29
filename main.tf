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

resource "aws_s3_bucket" "aaaa09340534-034593-4050343-4x" {
  bucket = "my-tf-test-bucket2019019109039393"
  acl    = "private"
}

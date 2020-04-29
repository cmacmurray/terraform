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

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket201901910"
  acl    = "private"
}

locals {
  remote_state_lock_dynamodb_table = "terraform-state-lock-dynamo-_________"
  remote_state_bucket_name         = "terraform-state-storage-_________"
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = local.remote_state_bucket_name
    key            = "terraform/base/terraform.tfstate"
    dynamodb_table = local.remote_state_lock_dynamodb_table
  }
}

resource "aws_s3_bucket" "terraform_state_storage" {
  bucket = local.remote_state_bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name      = "S3 Remote Terraform State Store"
    terraform = "true"
  }
}

resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name           = local.remote_state_lock_dynamodb_table
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name      = "DynamoDB Terraform State Lock Table"
    terraform = "true"
  }
}

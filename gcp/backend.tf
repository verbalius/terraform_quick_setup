locals {
  remote_state_bucket_name = "terraform-state-storage-_________"
}

terraform {
  backend "gcs" {
    bucket = local.remote_state_bucket_name
    prefix = "terraform/base/"
  }
}

resource "google_storage_bucket" "terraform_state_storage" {
  name          = local.remote_state_bucket_name
  location      = "EU" # <----------------------------------------------<<
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
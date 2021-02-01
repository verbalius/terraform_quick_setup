terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source  = "hashicorp/gcp"
      version = "~> 3.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }
  }
}

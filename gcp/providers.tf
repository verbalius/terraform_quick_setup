provider "google" {
  region  = var.gcp_region
  zone    = var.gcp_zone
  project = var.gcp_project_id
}
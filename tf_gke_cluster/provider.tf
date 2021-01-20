provider "google" {
  # version     = "2.7.0"
  //credentials = file(var.credentials)
  credentials = file("~/.config/gcloud/application_default_credentials.json")
  project     = var.project
  region      = var.region
}

terraform {
  required_version = "~> 0.14"
  backend "remote" {
    organization = "prennovate"
    hostname     = "app.terraform.io"
    # Fill Workspace
    workspaces {
      name = "ajocard-iac-gke-cluster"
    }
  }
}
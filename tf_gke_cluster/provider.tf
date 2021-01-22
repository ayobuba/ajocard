provider "google" {
  # version     = "2.7.0"
  credentials = file(var.credentials)
  //credentials = file("/Users/ryu/IntelliJProjects/AjoCard/.idea/devops-challenge-302120-f95db89fda4a.json")
  project     = var.project_id
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
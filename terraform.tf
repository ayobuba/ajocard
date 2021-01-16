terraform {
  required_version = "~> 0.14"
  backend "remote" {
    organization = "prennovate"
    hostname = "app.terraform.io"
    # Fill Workspace
    workspaces {
      name = "nomad-practice-linux-academy"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.20"
    }
  }
}




provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "kubernetes" {
//  load_config_file       = "false"
//  host                   = var.cluster_endpoint
//  token                  = var.cluster_token
//  cluster_ca_certificate = base64decode(var.cluster_ca_cert)
}


terraform {
  required_version = "~> 0.14"
  backend "remote" {
    organization = "prennovate"
    hostname = "app.terraform.io"
    # Fill Workspace
    workspaces {
      name = "ajocard-iac-kubernetes-app"
    }
  }
}

//terraform {
//  required_providers {
//    aws = {
//      source = "hashicorp/aws"
//      version = "~> 3.20"
//    }
//  }
//}
//




provider "random" {
}

provider "local" {

}

provider "null" {

}

provider "template" {

}
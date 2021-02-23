
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "eks_details" {
  source     = "../tf_eks_cluster"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = module.eks_details.cluster_endpoint
  token                  = module.eks_details.cluster-token
  cluster_ca_certificate = base64decode(module.eks_details.cluster-ca-cert)
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
//  backend "remote" {
//    hostname     = "prenovate.scalr.io"
//    organization = "env-ta3cdcbgqnk42ao"
//
//    workspaces {
//      name = "ajocard-iac-kubernetes-app"
//    }
//  }
//}
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
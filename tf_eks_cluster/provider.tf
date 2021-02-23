provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

terraform {
  required_version = "~> 0.14"
  backend "remote" {
    organization = "prennovate"
    hostname     = "app.terraform.io"
    # Fill Workspace
    workspaces {
      name = "ajocard-iac-eks-cluster"
    }
  }
}
//
//terraform {
//  backend "remote" {
//    hostname = "prenovate.scalr.io"
//    organization = "env-ta3cdcbgqnk42ao"
//
//    workspaces {
//      name = "ajocard-tf-eks-cluster"
//    }
//  }
//}
// ajocard-iac-kubernetes-app
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.20"
    }
  }
}





provider "random" {
}

provider "local" {

}

provider "null" {

}

provider "template" {

}
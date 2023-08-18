provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}
terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      //version = "~> 3.1.2"
    }
    helm = {
      source  = "hashicorp/helm"
      //version = "~> 2.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      //version = "~> 2.3.2"
    }
    aws = {
      source  = "hashicorp/aws"
      //version = "~> 3.47.0"
    }
  }
}

provider "random" {}
provider "local" {}
provider "null" {}
provider "template" {}
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name,
      "--profile",
      "psirs-cloud-admin"
    ]
  }
}





//provider "kubernetes" {
//  //load_config_file       = "false"
//  host                   = data.aws_eks_cluster.cluster.endpoint
//  token                  = data.aws_eks_cluster_auth.cluster.token
//  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
//}

//terraform {
//  required_version = "~> 0.14"
//  backend "remote" {
//    organization = "ajocard-engineering"
//    hostname     = "app.terraform.io"
//    # Fill Workspace
//    workspaces {
//      name = "Dev-EKS-Ajocard"
//    }
//  }
//}

//terraform {
//  backend "remote" {
//    hostname     = "prenovate.scalr.io"
//    organization = "env-ta3cdcbgqnk42ao"
//
//    workspaces {
//      name = "Ajocard"
//    }
//  }terraform init -migrate-state
//│
//}

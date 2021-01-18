variable "aws_region" {
  type        = string
  description = "AWS Region."
  //  default     = "us-east-2"
}

variable "app_name" {
  type        = string
  description = "AjeCard Devops Challenge"
  default     = "AjeCard-EKS"
}

variable "app" {
  type        = string
  description = "Application instance name (ie. honolulu, customer_name, department, etc.)."
  default     = "ajocard"
}

variable "app_stage" {
  type        = string
  description = "Application stage (ie. dev, prod, qa, etc)."
  default     = "dev"
}

variable "global_tags" {
  type = map(string)

  default = {
    Provisioner = "Terraform"
    Owner       = "shekarau buba"
  }
}

//variable "ami" {
//  type        = string
//  description = "Default ami used in the tutorial"
//
//}


variable "access_key" {
  type        = string
  description = "Access Key"

}

variable "secret_key" {
  type        = string
  description = "Secret Access Key"
}

variable "region" {
  default = "eu-west-2"
}

variable "instance_type" {
  # Smallest recommended, where ~1.1Gb of 2Gb memory is available for the Kubernetes pods after ‘warming up’ Docker, Kubelet, and OS
  default = "t2.micro"
  type    = string
}

variable "kms_key_arn" {
  default     = ""
  description = "KMS key ARN to use if you want to encrypt EKS node root volumes"
  type        = string
}

variable "open_vpn_ami" {
  description = "ami of open vpn in eu-west-2"
}

variable "eks_cluster_name" {
  default = "k8s-deepdive-eks-upOqXzTv"
}

# OpenVPN Variables
variable "VpnInitialUsername" {
  default = ""
}

variable "VpnInitialPassword" {
  default = ""
}

variable "vpn_key_2" {
  default = "vpn.server.routing.private_network.2"
}

variable "vpn_key_1" {
  default = "vpn.server.routing.private_network.1"
}

variable "SecondaryVPCCidr" {
  default = "100.64.0.0/16"
}

variable "AllowedIpRange" {
  default = "0.0.0.0/0"
}

variable "node-docker-image" {
  description = "Name of Node.js Docker image to deploy"
  default = "ayobuba/ajocard-sample-app:latest"
}

variable "go-docker-image" {
  description = "Name of Go Docker image to deploy"
  default = "ayobuba/go-docker:latest"
}

variable "cluster_token" {}

variable "cluster_endpoint" {}

variable "cluster_ca_cert" {}
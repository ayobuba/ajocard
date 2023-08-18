data "aws_eks_cluster" "cluster" {
  name = module.cpp_eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cpp_eks.cluster_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_availability_zones" "azs" {
  state = "available"
}

#data "aws_subnet_ids" "public" {
#  vpc_id = module.cpp_vpc.vpc_id
#  tags = {
#    "kubernetes.io/role/elb" = 1
#  }
#}
#data "aws_subnets" "public" {
#  vpc_id
#  tags = {
#
#  }
#}

data "aws_vpc" "default" {
  default = true
}

#data "aws_subnet_ids" "default" {
#  vpc_id = data.aws_vpc.default.id
#}
//data "terraform_remote_state" "eks" {
//  backend = "local"
//
//  config = {
//    path = "/Users/ryu/IntelliJProjects/AjoCard/tf_eks_cluster/terraform.tfstate"
//  }
//}

data "aws_vpc" "sc" {
  id = module.cpp_vpc.vpc_id
}

data "aws_autoscaling_groups" "groups" {
  filter {
    name   = "tag-key"
    values = ["eks:nodegroup-name"]
  }

  #  filter {
  #    name   = "eks:nodegroup-name"
  #    values = ["cpp-spot-1e"]
  #  }
}



data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_availability_zones" "azs" {
  state = "available"
}

//data "aws_subnet_ids" "public" {
//  vpc_id = module.vpc.vpc_id
//  tags = {
//    "kubernetes.io/role/elb" = 1
//  }
//}

//data "aws_subnet" "example" {
//  for_each = data.aws_subnet_ids.public.ids
//  id       = each.value
//}
//


data "aws_vpc" "default" {
  id = module.vpc.vpc_id
}

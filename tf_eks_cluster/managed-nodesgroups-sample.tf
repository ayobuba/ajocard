#module "eks-managed-ng" {
#  source = "./base/eks-managed-node-group"
#  cluster_name = "CPP-Ut"
#  subnet_ids = [data.aws_subnet_ids.default.ids]
#
#}
#variable "access_key" {
#
#}
#variable "secret_key" {
#
#}

#variable "nodegroup_role_name" {}

variable "aws_region" {
  description = "AWS region "
}
variable "aws_autoscaling_group_name" {}

variable "prefix_sc_dev_us" {
  default = "sc-dev-us"
}
variable "prefix_sc_prod_eu" {
  default = "sc-prod-eu"
}
variable "prefix_sc_prod_us" {
  default = "sc-prod-us"
}
variable "sqs_que_prefix" {}

variable "aws_account_id" {}

#variable "cluster_name" {}

variable "vpc_id" {
  default = "vpc-0f5b20b0889605ad2"
}

#variable "launch_template_version" {
#
#}
#variable "launch_template_name" {
#
#}
#dont use
#resource "aws_eks_node_group" "sc-stg-ng" {
#  for_each        = { for ng in var.managed_node_groups : ng.name => ng }
#  cluster_name    = var.cluster_name
#  node_group_name = join("-", [aws_eks_cluster.cp.name, each.key])
#  node_role_arn   = aws_iam_role.ng.0.arn
#  subnet_ids      = local.subnet_ids
#  ami_type        = lookup(each.value, "ami_type", local.default_eks_config.ami_type)
#  instance_types  = [lookup(each.value, "instance_type", local.default_eks_config.instance_type)]
#  version         = aws_eks_cluster.cp.version
#  tags            = merge(local.default-tags, var.tags)
#
#  scaling_config {
#    max_size     = lookup(each.value, "max_size", 3)
#    min_size     = lookup(each.value, "min_size", 1)
#    desired_size = lookup(each.value, "desired_size", 1)
#  }
#
#  launch_template {
#    id      = aws_launch_template.mng[each.key].id
#    version = aws_launch_template.mng[each.key].latest_version
#  }
#
#  lifecycle {
#    create_before_destroy = true
#    ignore_changes        = [scaling_config[0].desired_size]
#  }

#  depends_on = [
#    aws_iam_role.ng,
#    aws_iam_role_policy_attachment.eks-ng,
#    aws_iam_role_policy_attachment.eks-cni,
#    aws_iam_role_policy_attachment.ecr-read,
#    time_sleep.wait,
#  ]
#}
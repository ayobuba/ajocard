data "aws_subnet_ids" "sc-stg-eks-subnets" {
  vpc_id = var.vpc_id
}

variable "nodes_role_policy_arn" {
  description = "IAM role name for eks nodes"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile for eks nodes"
  type        = string
  default     = "sc-stg-eks-worker"
}

#data "aws_iam_role" "role" {
#  name = var.nodes_role_policy_name
#}

data "aws_iam_instance_profile" "main" {
  name = var.iam_instance_profile_name
}

variable "nodes_security_group_id" {
  description = "Stage Security group for all nodes in the cluster"
}
data "aws_security_group" "selected" {
  id = var.nodes_security_group_id
}
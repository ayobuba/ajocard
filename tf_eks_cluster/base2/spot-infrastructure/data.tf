data "aws_autoscaling_groups" "sc_stg_groups" {
  filter {
    name   = "tag-key"
    values = ["eks:nodegroup-name"]
  }

    filter {
      name   = "tag-value"
      values = ["sc-stg-eks-worker-asg"]
    }
}

data "aws_subnet_ids" "sc-stg-eks-subnets" {
  vpc_id = var.vpc_id
}
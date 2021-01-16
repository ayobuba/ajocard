module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "13.2.1"
  cluster_name    = local.cluster_name
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets





  tags = {
    Environment = var.app_stage
    GithubRepo  = "Course_Practical_Guide_EKS"
    GithubOrg   = "ayobuba"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 3
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      key_name                      = var.KeyName

    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 2
      key_name                      = var.KeyName
    },
  ]
}


//  terraform state rm 'module.eks.kubernetes_config_map.aws_auth[0]'


################################
## Setting up the EKS Cluster ##
################################
module "cpp_eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.22.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.24"
  vpc_id = module.cpp_vpc.vpc_id
  subnets         = module.cpp_vpc.private_subnets
  worker_create_cluster_primary_security_group_rules = true
  map_roles = [
    {
      rolearn  = "arn:aws:iam::557968956216:role/cloudcraft"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["cloudcraft-view-only"]
    },
  ]

  tags = {
    Environment = var.app_stage
    GithubRepo  = "https://github.com/ayobuba/cpp"
    GithubOrg   = "ayobuba"
  }
  node_groups = {
    spot-1 = {
      name                    = "cpp-spot-1e"
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      k8s_labels = {
        Environment = "staging"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
      additional_tags = {
        ExtraTag = "node-group-1"
      }
//      taints = [
//        {
//          key    = "dedicated"
//          value  = "gpuGroup"
//          effect = "NO_SCHEDULE"
//        }
//      ]
    },
    spot-2 = {
      name                    = "cpp-spot-2f"
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      k8s_labels = {
        Environment = "staging"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
      additional_tags = {
        ExtraTag = "node-group-2"
        name = "node-22"
      }
//      taints = [
//        {
//          key    = "dedicated"
//          value  = "gpuGroup"
//          effect = "NO_SCHEDULE"
//        }
//      ]
    }
  }
#  worker_groups_launch_template = [
#    {
#      name                    = "socialchorus-spot-1"
#      override_instance_types = ["t3a.medium","t4g.medium"]
#      spot_instance_pools     = 3
#      spot_allocation_strategy  = "lowest-price"
#      asg_max_size            = 10
#      asg_min_size = 6
#      asg_desired_capacity    = 6
#      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
#      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
#      public_ip               = true
#      autoscaling_enabled       = true
#    },
#    {
#      name                    = "socialchorus-spot-2"
#      override_instance_types = ["t3a.small","t4g.small", "t2.small"]
#      spot_instance_pools     = 3
#      spot_allocation_strategy  = "lowest-price"
#      asg_max_size            = 5
#      asg_min_size = 3
#      asg_desired_capacity    = 3
#      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
#      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
#      public_ip               = true
#      autoscaling_enabled       = true
#        },
#  ]
#
#  worker_groups = [
#    {
#      name                          = "node-group-1"
#      instance_type                 = "t2.micro"
#      additional_userdata           = "echo foo bar"
#      asg_desired_capacity          = 1
#      asg_min_size                  = 1
#      asg_max_size                  = 2
#      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
#      //key_name                      = var.KeyName
#
#    },
#    {
#      name                          = "node-group-2"
#      instance_type                 = "t2.nano"
#      additional_userdata           = "echo foo bar"
#      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
#      asg_desired_capacity          = 1
#      asg_min_size                  = 1
#      asg_max_size                  = 2
#
#      //key_name                      = var.KeyName
#    },
#  ]

depends_on = [
module.cpp_vpc
]
}



############################
## Null Resource for EKS  ##
############################
resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.cluster_name} --profile psirs-cloud-admin"
#    command = "aws eks --region us-east-2 update-kubeconfig --name education-eks-8oKYeBFn --profile psirs-cloud-admin"
  }
  depends_on = [
    module.cpp_eks
  ]
}

#module "ook-eks" {
#  source  = "Young-ook/eks/aws"
#  version = "2.0.4"
#  # insert the 1 required variable here
#  subnets = []
#}
#
#module "SPHTech-Platform-eks" {
#  source  = "SPHTech-Platform/eks/aws"
#  version = "0.10.1"
#  # insert the 3 required variables here
#}
#
#module "aurora-recovery" {
#  source  = "terraform-aws-modules/rds-aurora/aws"
#  version = "6.2.0"
#  #  create_cluster = var.enable_restore
#  #  restore_to_point_in_time = {
#  #    source_cluster_identifier = local.db_name
#  #    restore_to_time           = var.restore_to_time
#  #  }
#}


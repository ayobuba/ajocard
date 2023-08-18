#module "eks-node-group" {
#  source  = "./base/cloudposse-nodegroup/eks-node-group"
#  name = "clodposse-NG"
#  #source  = "cloudposse/eks-node-group/aws"
##  version = "0.28.0"
#  # insert the 20 required variables here
#  cluster_name = module.cpp_eks.cluster_id
#  ami_type = "CUSTOM"
##  instance_types = ["t3.large","t3.medium"]
#  desired_size = 2
#  max_size     = 3
#  min_size     = 1
#  capacity_type = "SPOT"
#  subnet_ids   = [ for s in sort(module.cpp_vpc.public_subnets) : s]
##    module.cpp_vpc.public_subnets,
##    module.cpp_vpc.private_subnets,
##  ]
#  launch_template_id = [
#    "lt-003ef6cf2f78eec92"
#  ]
#
#}

#module "stg_node_termination_handler" {
#  source       = "./base/node-termination-handler"
#  enabled      = true
#  cluster_name = module.cpp_eks.cluster_id
#  //cluster_name = module.eks.cluster.name
#  oidc         = local.oidc_map
#  tags         = { env = "stg" }
#}
#Aalex123.@
#module "stg_infrastructure_provisioning" {
#  source = "./base/spot-infrastructure"
#  aws_autoscaling_group_name = "eks-babef466-20e9-58eb-dff1-ddcf5dda3cec"
#  aws_region = var.aws_region
#  aws_account_id = var.aws_account_id
#  sqs_que_prefix = "cpp-stg-us"
#}

#module "sc-eks-node-group" {
#  #source  = "./base/cloudposse-nodegroup/eks-node-group"
#  name = "clodposse-NG"
#  source  = "cloudposse/eks-node-group/aws"
#    version = "0.28.0"
#  # insert the 20 required variables here
#  cluster_name = module.cpp_eks.cluster_id
#  ami_type = "CUSTOM"
#  #  instance_types = ["t3.large","t3.medium"]
#  desired_size = 2
#  max_size     = 3
#  min_size     = 1
#  capacity_type = "SPOT"
#  subnet_ids   = [ for s in sort(module.cpp_vpc.public_subnets) : s]
#  #    module.cpp_vpc.public_subnets,
#  #    module.cpp_vpc.private_subnets,
#  #  ]
#  launch_template_id = [
#    "lt-003ef6cf2f78eec92"
#  ]
#
#}

#module "sc_stg_sc_launch_template" {
#  source                            = "./base2/launch-template-module"
#  ec2_disk                          = "20"
#  nodes_defaults                    = var.nodes_defaults
#  nodes_role_policy_arn             = "arn:aws:iam::557968956216:role/CPP-Ut20211223190133743000000003"
#  system_reserved_ephemeral_storage = "10Gi"  nodes_security_group_id           = module.cpp_eks.cluster_security_group_id
#  cluster_defaults                  = var.cluster_defaults
#  #added
#  node_group_name           = "sc-stg-ng"
#  cluster_name              = "sc-stg-cluster"
#  nodegroup_role_name       = "sc-stg-ng-node-group-role"
#  desired_size              = 10
#  max_size                  = 30
#  min_size                  = 5
#  node_group_instance_types = [for s in var.node_group_instance_types : s]
#  subnet_ids                = [for s in sort(var.subnet_ids) : s]
#}

#module "cloudposse-demo-eks-node-group" {
#  source  = "cloudposse/eks-node-group/aws"
#  version = "0.28.0"
#  # insert the 20 required variables here
#}

#module "eks-node-group" {
#  source  = "cloudposse/eks-node-group/aws"
#  version = "0.28.0"
#  # insert the 20 required variables here
#
#}

#module "test-aws-node-termination-handler" {
#  source = "./base/nth"
#  node_termination_handler_version = "1.13.3"
#  k8s_node_selector = {
#    "eks.amazonaws.com/capacityType" = "SPOT"
#  }
#}

variable "prefix_sc_dev_us" {
  default = "sc-dev-us"
}
variable "prefix_sc_prod_eu" {
  default = "sc-prod-eu"
}
variable "prefix_sc_prod_us" {
  default = "sc-prod-us"
}
variable "prefix_sc_stg_us" {
  default = "sc-stg-us"
}

variable "aws_account_id" {
  default = "557968956216"
}

variable "clustername" {
  default = "sc-stg-cluster"
}


resource "aws_iam_openid_connect_provider" "oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = "https://oidc.eks.eu-west-1.amazonaws.com/id/1D2480E3298450F9AF47259AF62C0384"
  #  url             = aws_eks_cluster.cp.identity.0.oidc.0.issuer
}


output "oidc" {
  description = "The OIDC provider attributes for IAM Role for ServiceAccount"
  value = zipmap(["url", "arn"], [local.oidc["url"], local.oidc["arn"]]
  )
}

output "asg" {
  value = local.asg_names
  //value = [data.aws_autoscaling_groups.groups.names]
}

variable "nodes_defaults" {
  description = "Default values for target groups as defined by the list of maps."
  type        = map(any)

  default = {
    name                 = "sc-stg-eks-worker"             # Name for the eks workers.
    ami_id               = "ami-0b8514ea172997c03"         # AMI ID for the eks workers. If none is provided, Terraform will searchfor the latest version of their EKS optimized worker AMI.
    asg_desired_capacity = "10"                            # Desired worker capacity in the autoscaling group.
    asg_max_size         = "30"                            # Maximum worker capacity in the autoscaling group.
    asg_min_size         = "10"                            # Minimum worker capacity in the autoscaling group.     # Size of the workers instances.
    key_name             = "sc-production-master-01192016" # The key name that should be used for the instances in the autoscaling group
    ebs_optimized        = false                           # sets whether to use ebs optimization on supported types.
    public_ip            = false                           # Associate a public ip address with a worker
  }
}

variable "cluster_defaults" {
  description = "Default values for target groups as defined by the list of maps."
  type        = map(any)
  default = {
    name = "sc-stg-cluster" # Name for the eks cluster.
  }
}
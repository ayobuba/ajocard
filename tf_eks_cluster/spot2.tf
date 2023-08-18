#module "stg_node_termination_handler" {
#  source       = "./base2/node-termination-handler"
#  enabled      = true
#  cluster_name = module.cpp_eks.cluster_id
#  oidc         = local.oidc_map
#  tags         = { env = "stg" }
#}
#
#module "stg_infrastructure_provisioning" {
#  source                     = "./base2/spot-infrastructure"
#  aws_autoscaling_group_name = "eks-babef466-20e9-58eb-dff1-ddcf5dda3cec"
#  aws_region                 = var.aws_region
#  aws_account_id             = var.aws_account_id
#  sqs_que_prefix             = "cpp-stg-us"
#  #depends_on                 = [module.sc_stg_sc_launch_template]
#}

#module "cloudposse-eks-node-group" {
#  source  = "cloudposse/eks-node-group/aws"
#  version = "0.28.0"
##  source  = "./base2/cp-nodegroup"
#  # insert the 20 required variables here
#  cluster_name = module.cpp_eks.cluster_id
#  subnet_ids = [module.cpp_vpc.private_subnets]
#  instance_types = ["t3.medium", "t2.large"]
#  max_size = 2
#  min_size = 1
#  desired_size = 2
#  capacity_type = "SPOT"
#  namespace = "sc"
#}

#module "local-cloudposse-eks-node-group" {
#    source  = "./base2/cp-nodegroup/cloudposse-eks-node-group"
#  # insert the 20 required variables here
#  cluster_name = module.cpp_eks.cluster_id
#  subnet_ids = [module.cpp_vpc.private_subnets]
#  instance_types = ["t3.medium", "t2.large"]
#  max_size = 2
#  min_size = 1
#  desired_size = 2
#  capacity_type = "SPOT"
#  namespace = "sc"
#  launch_template_id = [module.cpp_eks.workers_launch_template_ids]
#
#}

#
#module "eks-node-group" {
#source  = "cloudposse/eks-node-group/aws"
#version = "0.28.0"
## insert the 20 required variables here
#}
#module "umotiff-eks-node-group" {
#  source  = "./base2/nodegroup"
#  # insert the 13 required variables here
#  cluster_name = module.cpp_eks.cluster_id
#  desired_size = 1
#  max_size = 2
#  min_size = 1
#  subnet_ids = [module.cpp_vpc.private_subnets]
#  instance_types = ["t3.medium", "t2.large"]
#  capacity_type = "SPOT"
#  taints = [
#    {
#
#    }
#  ]
#}

#module "sc_stg_sc_launch_template" {
#  source                            = "./base2/launch-template-module"
#  ec2_disk                          = "250"
#  evict_hard_memory_avail           = "2Gi"
#  evict_hard_nodefs_avail           = "10%"
#  evict_soft_grace_imagefs          = "10%"
#  evict_soft_grace_memory           = "1m10s"
#  evict_soft_grace_nodefs_inodes    = "1m"
#  evict_soft_grace_nodefs_avail     = "1m"
#  evict_soft_imagefs_avail          = "15%"
#  evict_soft_memory_avail           = "32Gi"
#  evict_soft_nodefs_avail           = "15%"
#  evict_soft_inodes_free            = "10%"
#  eviction_max_pod_grace_period     = "900"
#  kube_reserved_cpu                 = "1000m"
#  kube_reserved_memory              = "4Gi"
#  kube_reserved_ephemeral_storage   = "10Gi"
#  max_pods                          = 100
#  nodes_defaults                    = var.nodes_defaults
#  nodes_role_policy_arn             = "arn:aws:iam::644921559645:role/sc-stg-eks-worker"
#  system_reserved_cpu               = "800m"
#  system_reserved_memory            = "4Gi"
#  system_reserved_ephemeral_storage = "10Gi"
#  nodes_security_group_id           = "sg-0ad13adb7465e7d67"
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
#
#variable "nodes_defaults" {
#  description = "Default values for target groups as defined by the list of maps."
#  type        = map(any)
#
#  default = {
#    name                 = "cpp-stg-eks-worker"             # Name for the eks workers.
#    ami_id               = "ami-0b8514ea172997c03"         # AMI ID for the eks workers. If none is provided, Terraform will searchfor the latest version of their EKS optimized worker AMI.
#    asg_desired_capacity = ""                            # Desired worker capacity in the autoscaling group.
#    asg_max_size         = "30"                            # Maximum worker capacity in the autoscaling group.
#    asg_min_size         = "10"                            # Minimum worker capacity in the autoscaling group.     # Size of the workers instances.
#    key_name             = "sc-production-master-01192016" # The key name that should be used for the instances in the autoscaling group
#    ebs_optimized        = false                           # sets whether to use ebs optimization on supported types.
#    public_ip            = false                           # Associate a public ip address with a worker
#  }
#}
#resource "aws_iam_openid_connect_provider" "oidc" {
#  client_id_list  = ["sts.amazonaws.com"]
#  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
#  url             = "https://oidc.eks.us-east-1.amazonaws.com/id/3AD1324D62BFD9E0843E0E41414B335"
#  #  url             = aws_eks_cluster.cp.identity.0.oidc.0.issuer
#}

# random strings are used for naming the EKS cluster, VPC and other resources
resource "random_string" "suffix" {
  length  = 8
  special = false
}

########################
## Setting up the VPC ##
########################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name                 = "${var.app}-VPC"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.azs.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true


  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}


################################
## Setting up the EKS Cluster ##
################################
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "13.2.1"
  cluster_name    = local.cluster_name
  cluster_version = "1.19"
  subnets         = module.vpc.private_subnets





  tags = {
    Environment = var.app_stage
    GithubRepo  = "https://github.com/ayobuba/AjoCard"
    GithubOrg   = "ayobuba"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "node-group-1"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      asg_min_size                  = 1
      asg_max_size                  = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      //key_name                      = var.KeyName

    },
    {
      name                          = "node-group-2"
      instance_type                 = "t2.micro"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 2
      asg_min_size                  = 3
      asg_max_size                  = 5

      //key_name                      = var.KeyName
    },
  ]
}


############################
## Worker Security Groups ##
############################
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

  //  ingress {
  //    from_port       = 0
  //    protocol        = "-1"
  //    to_port         = 0
  //    security_groups = [aws_security_group.NodeSecurityGroup.id]
  //    cidr_blocks     = ["0.0.0.0/0"]
  //
  //  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
  //  ingress {
  //    from_port       = 0
  //    protocol        = "-1"
  //    to_port         = 0
  //    security_groups = [aws_security_group.NodeSecurityGroup.id]
  //    cidr_blocks     = ["0.0.0.0/0"]
  //
  //  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}


############################
## Null Resource for EKS  ##
############################
resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.cluster_name}"
  }
}


//  terraform state rm 'module.eks.kubernetes_config_map.aws_auth[0]'

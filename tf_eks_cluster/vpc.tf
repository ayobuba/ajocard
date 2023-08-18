# random strings are used for naming the EKS cluster, VPC and other resources
resource "random_string" "suffix" {
  length  = 2
  special = false
}

########################
## Setting up the VPC ##
########################
module "cpp_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

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



############################
## Worker Security Groups ##
############################
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.cpp_vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

  //    ingress {
  //      from_port       = 0
  //      protocol        = "-1"
  //      to_port         = 0
  //      security_groups = [aws_security_group.NodeSecurityGroup.id]
  //      cidr_blocks     = ["0.0.0.0/0"]
  //
  //    }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = module.cpp_vpc.vpc_id

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
  vpc_id      = module.cpp_vpc.vpc_id

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



//  terraform state rm 'module.eks.kubernetes_config_map.aws_auth[0]'
// aws ecr get-login-password —-region eu-west-1  --profile ajocard | docker login —-username AWS —-password-stdin 313877844143.dkr.ecr.eu-west-1.amazonaws.com/ajocardengineering/user-user-service-dev

//aws ecr get-login-password --region eu-west-1 --profile ajocard | docker login --username AWS --password-stdin 313877844143.dkr.ecr.eu-west-1.amazonaws.com/ajocardengineering/user-user-service-dev
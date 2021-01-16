//data "aws_caller_identity" "current" {}
//
//data "aws_iam_account_alias" "current" {}
//
//data "aws_availability_zones" "azs" {
//  state = "available"
//}
//
//data "http" "myip" {
//  url = "https://ipv4.icanhazip.com"
//}

# Linux AMI
//data "aws_ssm_parameter" "LinuxAmi-Master" {
//  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
//}

# Ubuntu AMI VIA SSM
//data "aws_ssm_parameter" "ubuntu-focal" {
//  name = "/aws/service/canonical/ubuntu/server/16.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
//}

//data "aws_ami" "ubuntu" {
//  most_recent = true
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
//  }
//
//  filter {
//    name   = "virtualization-type"
//    values = ["hvm"]
//  }
//
//  owners = ["099720109477"] # Canonical
//}

//data "aws_security_group" "vpc_default_sg" {
//  name   = "default"
//  vpc_id = aws_vpc.vpc_master.id
//}
//
//data "template_file" "user-data" {
//  template = file("${path.module}/user-data.sh")
//  vars = {
//    ecs_cluster_name = aws_ecs_cluster.ecs_cluster.name
//  }
//}

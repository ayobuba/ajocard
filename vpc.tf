# Master eu-central-1
//resource "aws_vpc" "vpc_master" {
//  cidr_block           = "10.0.0.0/16"
//  enable_dns_support   = true
//  enable_dns_hostnames = true
//  tags = {
//    Name       = "master-vpc-jenkins",
//    DeployedBy = "Terraform"
//  }
//}

# Worker eu-west-2
//resource "aws_vpc" "vpc_master_london" {
//  provider             = aws.region_worker
//  cidr_block           = "192.168.0.0/16"
//  enable_dns_support   = true
//  enable_dns_hostnames = true
//  tags = {
//    Name       = "worker-vpc-jenkins",
//    DeployedBy = "Terraform"
//  }
//}
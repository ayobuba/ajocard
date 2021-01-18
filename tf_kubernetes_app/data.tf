data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_availability_zones" "azs" {
  state = "available"
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}


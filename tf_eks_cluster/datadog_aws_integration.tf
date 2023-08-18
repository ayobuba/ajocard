//resource "datadog_integration_aws" "socialchorus_sandbox" {
//  account_id = data.aws_caller_identity.current.account_id
//  role_name = "DataDogAWSIntegrationRole"
//  filter_tags = ["key;value"]
//  host_tags = ["key;value", "key2;value2"]
//
//  excluded_regions = ["us-west-1","us-west-2", "us-east-1", "us-east-2"]
//}

//module "datadog-cloudtrail_bucket" {
//  source  = "terraform-aws-modules/s3-bucket/aws"
//  version = "2.6.0"
//  # insert the 5 required variables here
//
//}
//
//module "datadog-integration" {
//  source  = "cloudposse/datadog-integration/aws"
//  version = "0.11.0"
//  # insert the 19 required variables here
//  integrations = ['all']
//  environment = "prod"
//  excluded_regions = ["us-west-1","us-west-2", "us-east-1", "us-east-2"]
//}
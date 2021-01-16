# Terraform boilerplate

Boilerplate repo for terraform projects.

## Features:
* `CircleCi` configuration

## Tools to configure:
* Configure `CircleCi` at https://circleci.com
* Install `terraform-docs` locally. You can manually run it by:
```
terraform-docs md . > README.md
```
* Configure [pre-commit](https://pre-commit.com/) hook. Before every commit the hook will properly format your tf files and also regenerate README.md using `terraform-docs`.
```
brew install pre-commit
pre-commit install # In project folder
```




## Best practices
* Use `kebab-case` to separate words. Do not use `PascalCase`, `camelCase`, `snake_case` or any other casing approach.
* Use the `global_tags` map variable to specify tags that you want to apply to all provisioned resources. `App`, `Instance`, and `Stage` tags will be automatically included so do not pass them in.
* Do not request *ACCOUNT_NUMBER* to user through variables. Such data can be fetched by [data sources](https://www.terraform.io/docs/providers/aws/). If you need to use *ACCOUNT_NUMBER* you can use the *local variable* that comes predefined in `locals.tf` file. You can use it like `${local.account_id}`.
* When naming resources use the handy *local variable* `name_prefix` that comes predefined in `locals.tf`. Such variable results in `app_name-app_instance-app_stage`. You can use it like `${local.name_prefix}-vpc` and it will create a resource like the following: `wordpress-customer_x-prod-vpc`.

* Configure backend for `af-south-1`.
```
bucket = "ca-central-1-boiler-state"
region = "ca-central-1"
dynamodb_table = "ca-central-1-terraform-locks"
encrypt = true

terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "af-south-1"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"

  shared_credentials_file = "/Users/ryu/.aws/credentials"
  profile = "default"
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = "af-south-1-boiler-state"

  // This is only here so we can destroy the bucket as part of automated tests. You should not copy this for production
  // usage
  force_destroy = false

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "af-south-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"


  attribute {
    name = "LockID"
    type = "S"
  }
}

output "bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "region" {
  value = aws_s3_bucket.terraform_state.region
}

output "dynamo" {
  value = aws_dynamodb_table.terraform_locks.name
}

```
provider "aws" {
  region = "eu-west-1"
}

locals {
  application_name = "simple"
}

module "dynamodb" {
  source = "../../"

  application_name = local.application_name
  table_name       = "table"

  hash_key = "PrimaryKey"

  billing_mode = "PAY_PER_REQUEST"

  tags = {
    Example = "Simple"
  }
}

provider "aws" {
  region = "eu-west-1"
}

locals {
  name_prefix      = "example"
  application_name = "simple"
}

module "dynamodb" {
  source = "../../"

  name_prefix      = local.name_prefix
  application_name = local.application_name
  table_name       = "table"

  hash_key = "PrimaryKey"

  billing_mode = "PAY_PER_REQUEST"

  tags = {
    Example = "Simple"
  }
}

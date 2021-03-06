provider "aws" {
  region = "eu-west-1"
}

locals {
  name_prefix      = "example"
  application_name = "autoscaling"
}

module "dynamodb" {
  source = "../../"

  name_prefix      = local.name_prefix
  application_name = local.application_name
  table_name       = "table"

  hash_key = "PrimaryKey"

  billing_mode       = "PROVISIONED"
  min_read_capacity  = 50
  max_read_capacity  = 500
  min_write_capacity = 10
  max_write_capacity = 100

  tags = {
    Example = "Simple"
  }
}

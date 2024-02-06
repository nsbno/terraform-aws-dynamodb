provider "aws" {
  region = "eu-west-1"
}

module "dynamodb" {
  source = "../../"

  table_name   = "table"
  hash_key     = "PrimaryKey"
  billing_mode = "PAY_PER_REQUEST"
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "application_name" {
  description = "Name of the application that is using this table"
  type        = string
}

variable "table_name" {
  description = "Name of the table"
  type        = string
}

variable "billing_mode" {
  description = "Type of billing mode (PAY_PER_REQUEST/PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "min_read_capacity" {
  description = "Minimum read capacity if billing mode is PROVISIONED"
  type        = number
  default     = 5
}

variable "max_read_capacity" {
  description = "Maximum read capacity if billing mode is PROVISIONED"
  type        = number
  default     = 20
}

variable "min_write_capacity" {
  description = "Minimum write capacity if billing mode is PROVISIONED"
  type        = number
  default     = 5
}

variable "max_write_capacity" {
  description = "Maximum write capacity if billing mode is PROVISIONED"
  type        = number
  default     = 20
}

variable "hash_key" {
  description = "DynamoDB hash key"
  type        = string
}

variable "hash_key_type" {
  description = "DynamoDB hash key type"
  type        = string
  default     = "S"
}

variable "attributes" {
  description = "Additional attributes"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "stream" {
  type = object({
    enabled   = bool
    view_type = string
  })
  default = null
}

variable "global_secondary_indices" {
  description = "A map defining global secondary indices"
  type        = any
  default     = []
}

variable "enable_point_in_time_recovery" {
  description = "Enable Point-in-time recovery (PITR)"
  type        = bool
  default     = false
}

variable "ttl_attribute" {
  description = "Name of the attribute that stores the Time to live timestamp"
  type        = string
  default     = "Expires"
}

variable "ttl_enabled" {
  description = "Enable Time to live"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

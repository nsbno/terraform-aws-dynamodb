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

variable "range_key" {
  description = "DynamoDB range key"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "DynamoDB range key type"
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

variable "stream_enabled" {
  type    = bool
  default = false
}

variable "stream_view_type" {
  type    = string
  default = ""
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

variable "enable_deletion_protection" {
  description = "Enable deletion protection"
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

terraform {
  required_version = ">= 1.0.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

locals {
  all_attribs = concat(
    [{
      name = var.hash_key
      type = var.hash_key_type
    }],
    var.attributes
  )
}

resource "aws_dynamodb_table" "table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.min_read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.min_write_capacity : null
  hash_key       = var.hash_key

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  dynamic "attribute" {
    for_each = local.all_attribs
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "ttl" {
    for_each = var.ttl_enabled ? [1] : [0]
    content {
      attribute_name = var.ttl_attribute
      enabled        = true
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indices
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }
}

resource "aws_appautoscaling_target" "read_capacity_autoscaling_target" {
  count              = var.billing_mode == "PROVISIONED" ? 1 : 0
  min_capacity       = var.min_read_capacity
  max_capacity       = var.max_read_capacity
  resource_id        = "table/${aws_dynamodb_table.table.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "read_capacity_autoscaling_policy" {
  count              = var.billing_mode == "PROVISIONED" ? 1 : 0
  name               = "${aws_dynamodb_table.table.name}-read-capacity-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.read_capacity_autoscaling_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.read_capacity_autoscaling_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.read_capacity_autoscaling_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    target_value = 70
  }
}

resource "aws_appautoscaling_target" "write_capacity_autoscaling_target" {
  count              = var.billing_mode == "PROVISIONED" ? 1 : 0
  min_capacity       = var.min_write_capacity
  max_capacity       = var.max_write_capacity
  resource_id        = "table/${aws_dynamodb_table.table.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "write_capacity_autoscaling_policy" {
  count              = var.billing_mode == "PROVISIONED" ? 1 : 0
  name               = "${aws_dynamodb_table.table.name}-write-capacity-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.write_capacity_autoscaling_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.write_capacity_autoscaling_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.write_capacity_autoscaling_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    target_value = 70
  }
}

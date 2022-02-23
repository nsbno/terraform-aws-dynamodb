output "name" {
  description = "Dynamodb table name"
  value       = aws_dynamodb_table.table.name
}

output "id" {
  description = "Dynamodb table ID"
  value       = aws_dynamodb_table.table.id
}

output "arn" {
  description = "Dynamodb table ARN"
  value       = aws_dynamodb_table.table.arn
}

output "stream_arn" {
  description = "Dynamodb table stream ARN"
  value       = aws_dynamodb_table.table.stream_arn
}

output "stream_label" {
  description = "Dynamodb table stream label"
  value       = aws_dynamodb_table.table.stream_label
}

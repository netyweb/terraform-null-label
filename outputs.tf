output "id" {
  value       = local.enabled ? local.id : ""
}

output "project" {
  value       = local.enabled ? local.project : ""
}

output "stage" {
  value       = local.enabled ? local.stage : ""
}

output "name" {
  value       = local.enabled ? local.name : ""
}

output "attributes" {
  value       = local.enabled ? local.attributes : []
  description = "List of attributes"
}

output "tags" {
  value       = local.enabled ? local.tags : {}
}

output "context" {
  value       = local.output_context
  description = "Context of this module to pass to other label modules"
}
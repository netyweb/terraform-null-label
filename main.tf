locals {

  defaults = {
    label_order = ["project", "stage", "name", "attributes"]
    delimiter   = "-"
    replacement = ""
    # The `sentinel` should match the `regex_replace_chars`, so it will be replaced with the `replacement` value
    sentinel   = "~"
    regex_replace_chars = "/[^a-zA-Z0-9-]/"
    attributes = [""]
  }
  
  enabled = var.enabled

  project = lower(replace(coalesce(var.project, var.context.project, local.defaults.sentinel), local.defaults.regex_replace_chars, local.defaults.replacement))
  stage   = lower(replace(coalesce(var.stage, var.context.stage, local.defaults.sentinel), local.defaults.regex_replace_chars, local.defaults.replacement))
  name    = lower(replace(coalesce(var.name, var.context.name, local.defaults.sentinel), local.defaults.regex_replace_chars, local.defaults.replacement))
  attributes = compact(distinct(concat(var.attributes, var.context.attributes, local.defaults.attributes)))

  # ID
  generated_id = {
    project     = local.project
    stage       = local.stage
    name        = local.name
    attributes  = lower(join(local.defaults.delimiter, local.attributes))
  }

  labels = [for l in local.defaults.label_order : local.generated_id[l] if length(local.generated_id[l]) > 0]

  id = lower(join(local.defaults.delimiter, local.labels))
  
  # Tags
  generated_tags = {
    Name        = local.id
    Project     = local.project
    Stage       = local.stage
    Attributes  = lower(replace(join(local.defaults.delimiter, local.attributes), local.defaults.regex_replace_chars, local.defaults.replacement))
  }

  tags = merge(var.context.tags, local.generated_tags, var.tags)

  # Context of this label to pass to other label modules
  output_context = {
    enabled             = local.enabled
    project             = local.project
    stage               = local.stage
    name                = local.name
    attributes          = local.attributes
    tags                = local.tags
  }
}
# terraform-null-label

Terraform module designed to generate consistent names and tags for resources. Use `terraform-null-label` to implement a strict naming convention.

## Usage

### Example

```hcl
module "cpu_utilization_high_alarm_label" {
  source     = "livestorm/terraform-null-label"
  project    = "livestorm"
  stage      = "integ"
  name       = "backend-service"
  attributes = compact(concat(var.attributes, ["cpu", "utilization", "high"]))

  tags = {
    "Snapshot"     = "true"
  }
}
```
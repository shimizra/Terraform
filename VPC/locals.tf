locals {
  common_tags = {
    DevopsName  = var.devops_name
    GeneratedBy = var.generated_by
    Scope       = var.scope
    Owner       = var.owner
    Environment = var.environment
  }
}

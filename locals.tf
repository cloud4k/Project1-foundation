locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = "harjot"
    CostCenter  = "cloud"
  }
}
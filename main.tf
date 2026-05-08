provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "./modules/s3"

  project     = var.project
  environment = var.environment
  tags        = local.common_tags
}
module "vpc" {
  source = "./modules/vpc"

  project     = var.project
  environment = var.environment
  vpc_cidr    = "10.0.0.0/16"

  tags = local.common_tags
}
module "ec2" {
  source = "./modules/ec2"

  project       = var.project
  environment   = var.environment
  instance_type = var.instance_type
  instance_profile_name = module.iam.instance_profile_name
  subnet_id = module.vpc.public_subnet_id
  vpc_id    = module.vpc.vpc_id

  tags = local.common_tags
}
module "iam" {
  source = "./modules/iam"

  project     = var.project
  environment = var.environment

  tags = local.common_tags
}

terraform {
  required_version = "= 1.9.8"

  cloud {
    organization = "harjotscloud-org"

    workspaces {
      tags = ["platform"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
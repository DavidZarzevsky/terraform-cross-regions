terraform {
  backend "s3" {
    bucket  = "sre-spot-tf-state-prod"
    encrypt = true
    key     = "dev/eu-central-1/services/terraform.tfstate"
    profile = "SRE"
    region  = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
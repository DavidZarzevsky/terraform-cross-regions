terraform {
  backend "s3" {
    bucket  = ""
    encrypt = true
    key     = "dev/eu-central-1/services/terraform.tfstate"
    profile = ""
    region  = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



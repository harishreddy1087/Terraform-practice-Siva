terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0" # Allows 5.31.1, but not 5.32.0 or 6.0.0
    }
  }

  backend "s3" {
    bucket       = "hari-reddy-4747"
    key          = "dev/vpc.tfstate"
    region       = "us-east-1"
    use_lockfile = true # enabled use_lockfile = true, you are utilizing a newer Terraform feature (introduced in version 1.10) that simplifies state locking.
  }
}

provider "aws" {
  region = "us-east-1"

}



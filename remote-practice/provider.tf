terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }

  backend "s3" {
bucket = "my-terraform-state-bucket"
key = "global/s3/terraform.tfstate"
region = "us-east-1"
dynamodb_table = "terraform-state-lock-table"
encrypt = true
}

}

provider "aws" {
  region = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }
################3 
# below block is mandatory is store the state file in S3 and lock with DynamoDB
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
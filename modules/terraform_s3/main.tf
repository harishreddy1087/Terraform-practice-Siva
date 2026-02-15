resource "aws_s3_bucket" "module_s3_bucket" {
    bucket = var.bucket_name

    tags = {
      Name = var.bucket_name
      Environment = var.environment_type
    }
  
}
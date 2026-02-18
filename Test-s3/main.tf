
module "s3_bucket" {
  source           = "./modules/terraform_s3"
  bucket_name      = "${var.environment_type}-${var.bucket_name}"
  environment_type = var.environment_type

}
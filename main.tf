module "ec2_instance" {
  source           = "./modules/terraform_ec2"
  ami_id           = var.ami
  instance_type    = var.instance_type
  instance_name    = "${var.environment_type}-hari_instance"
  environment_type = var.environment_type

}

module "s3_bucket" {
  source           = "./modules/terraform_s3"
  bucket_name      = "${var.environment_type}-${var.bucket_name}"
  environment_type = var.environment_type

}
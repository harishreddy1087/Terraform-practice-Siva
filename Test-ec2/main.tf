module "ec2_instance" {
  source           = "./modules/terraform_ec2"
  ami_id           = var.ami
  instance_type    = var.instance_type
  instance_name    = "${var.environment_type}-hari_instance"
  environment_type = var.environment_type

}

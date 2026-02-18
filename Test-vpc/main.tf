module "vpc" {
  source               = "../modules/terraform_vpc"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnet_cidrs = var.public_subnet_cidrs
  public_ip_on_launch = var.public_ip_on_launch
  private_subnet_cidrs = var.private_subnet_cidrs
}

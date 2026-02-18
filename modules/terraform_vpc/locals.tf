#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones.html

locals {
  az_names = slice(data.aws_availability_zones.available.names, 0, 2)
}

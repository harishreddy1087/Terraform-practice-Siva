output "vpc_id" {
    value = aws_vpc.main_vpc.id
  
}

# by this way we can check the AZ availability in region us-east-1 which mentioned in provider
output "az_info" {
    value = data.aws_availability_zones.available
  
}
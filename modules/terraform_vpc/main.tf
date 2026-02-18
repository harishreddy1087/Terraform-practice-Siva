#*******************
# CREATING VPC
#*******************

resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = var.enable_dns_hostnames



    tags = {
      Name = "${var.project_name}-vpc-${var.environment}"
    }
  
}
# **********************************
# CREATING INTERNET
# **********************************
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  
  tags = {
    Name = "${var.project_name}-igw-${var.environment}"
  }

}



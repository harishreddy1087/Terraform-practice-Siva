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


# ************
# CREATING SUBNETS
# 2 -- HIGH AVAILABILITY ZONES

# PUBLIC 1A & 1B
# PRIVATE 1A & 1B
# DATABASE 1A &1B
# **************************

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main_vpc.id
  # enable public ip for public subnets== to check navigate to ec2 setup
  map_public_ip_on_launch = var.public_ip_on_launch
  cidr_block = var.public_subnet_cidrs[count.index]
  # below AZ will fetch the AZ name from the data source created below
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "${var.project_name}-public-subnet-${local.az_names[count.index]}-${var.environment}"
  }
}

# ***************
# PRIVATE SUBNETS
# ***************

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "${var.project_name}-private-subnet-${local.az_names[count.index]}-${var.environment}"
  }
  
}

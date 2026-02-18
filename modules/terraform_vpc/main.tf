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

# ****************
# DATABASE SUBNETS
# ****************

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "${var.project_name}-database-subnet-${local.az_names[count.index]}-${var.environment}"
  }
  
}

# *************
# DB SUBNET GROUP
# *************

#We use AWS DB Subnet Groups mainly when launching databases in private, secure, and highly available network locations

resource "aws_db_subnet_group" "db_grp" {
  name = var.aws_db_subnet_group
  subnet_ids = aws_subnet.database[*].id # we are keepinmg everything in the DB 
  tags = {
    Name = "${var.project_name}-db-subnet-grp-${var.environment}"
  }
  
}

# ***********
# CRRATING EIP
# ***********

resource "aws_eip" "eip" {
  count= length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-eip-${local.az_names[count.index]}-${var.environment}"
  }
  
}

# below code is for creating the EIP and setting it only for one public subnet
# resource "aws_eip" "eip1" {
#   domain = "vpc"
  
# }

#   tags = {
#     Name = "${var.project_name}-eip-${local.az_names}-${var.environment}"
#   }
  
# }

# *************
# CREATING NAT GATEWAYS
# *************
#creating two NAT Gate ways bcz high availability
resource "aws_nat_gateway" "nat" {
  # we are creating 1 NAT gateway per public subnet
  count = length(var.public_subnet_cidrs)
  # assigning elastic IP to each NAT gateway
  allocation_id = aws_eip.eip[count.index].id
  # assigning each NAT gateway to each public subnet
  subnet_id = aws_subnet.public[count.index].id
  
  tags = {
    Name = "${var.project_name}-nat-${local.az_names[count.index]}-${var.environment}"
  }
  
  depends_on = [aws_internet_gateway.igw]
  
  
}

# below code is for creating the NAT gateway and setting only for one public subnet
# resource "aws_nat_gateway" "nat1" {
#   allocation_id = aws_eip.eip1.id
#   subnet_id = aws_subnet.public[0].id # by giving zero here so it will create only one

#   tags = {
#     Name = "${var.project_name}-nat1-${local.az_names}-${var.environment}"
#   }
  
# }

# **************
# CREATING ROUTE TABELS
# we are creating 3 route tables one for public, one for private and one for database because internet is coiming to bastion host through internt gateway. from igw nat gateway will get by hiding the private ip
# **************
resource "aws_route_table" "public_rt" {
  # here we are creating the routetable for only one subnet that is first AZ
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-public-rt-${local.az_names[0]}-${var.environment}"
  }
  
}

# PRIVATE ROUTE TABLE to get the internet
resource "aws_route_table" "private_rt" {
  # here we are creating the routetable for only one subnet that is first AZ
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-private-rt-${local.az_names[0]}-${var.environment}"
  }
  
}


# DATABASE ROUTE TABLE to get the internet
resource "aws_route_table" "db_rt" {
  # here we are creating the routetable for only one subnet that is first AZ
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-database-rt-${local.az_names[0]}-${var.environment}"
  }
  
}

#
# ******************
# ROUTES
# ******************

# PUBLIC ROUTE TABLE ROUTIMG
# public route table have internet connectivity
# we have to associate the route table with the public subnets with internet gateway

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = var.destination_cidr
  gateway_id = aws_internet_gateway.igw.id # public subnet have internet so using aws_internet

}

# PRIVATE ROUTE TABLE ROUTING
resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = var.destination_cidr
  nat_gateway_id = aws_nat_gateway.nat[0].id # private subnet have NAT gateway. bcz no public ip so no direct internet
  
}


# DATABASE ROUTE TABLE ROUTING
resource "aws_route" "database_route" {
  route_table_id = aws_route_table.db_rt.id
  destination_cidr_block = var.destination_cidr
  nat_gateway_id = aws_nat_gateway.nat[0].id # database subnet have NAT gateway. bcz no public ip so no direct internet
  
}


# ******************
# ASSOCIATING ROUTETABLES WITH SUBNETS
# ******************

# PUBLIC SUBNET ASSOCIATION
# here we have two public subnets and we have only one public routable we have associate one public route table with two public subnets
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public_rt.id
  
}
# PRIVATE SUBNET ASSOCIATION
# here we have two private subnets and we have only one private routable we have associate one private route table with two private subnets
resource "aws_route_table_association" "private" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.private[count.index].id 
  route_table_id = aws_route_table.private_rt.id
  
}

#DATABASE SUBNET ASSOCIATION
# here we have two database subnets and we have only one database routable we have associate one database route table with two database subnets
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id = aws_subnet.database[count.index].id 
  route_table_id = aws_route_table.db_rt.id
  
}
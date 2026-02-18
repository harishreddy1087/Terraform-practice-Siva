variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "enable_dns_hostnames" {
    type = string
}

variable "public_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.public_subnet_cidrs) == 2 
      error_message = "please provide 2 valid public subnet CIDR"
    }
 
}

variable "public_ip_on_launch" {
    type = bool
  
}

variable "private_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.private_subnet_cidrs) == 2 
      error_message = "please provide 2 valid private subnet CIDR"
    }
  
}

variable "database_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.database_subnet_cidrs) == 2 
      error_message = "please provide 2 valid database subnet CIDR"
    }
  
}

variable "aws_db_subnet_group" {
    type = string

  
}

variable "destination_cidr" {
    type = string
    
  
}
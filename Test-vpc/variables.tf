variable "project_name" {
  type    = string
  default = "expense"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}

variable "enable_dns_hostnames" {
  type    = bool
  default = true

}

variable "public_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]


}

variable "public_ip_on_launch" {
  type    = bool
  default = true

}

variable "private_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.11.0/24", "10.0.12.0/24"]

}

variable "database_subnet_cidrs" {
  type    = list(any)
  default = ["10.0.21.0/24", "10.0.22.0/24"]

}

variable "aws_db_subnet_group" {
  type    = string
  default = "main-db-subnet-group"

}

variable "destination_cidr" {
    type = string
    default = "0.0.0.0/0"
  
}
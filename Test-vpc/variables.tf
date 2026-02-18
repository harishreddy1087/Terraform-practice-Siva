variable "project_name" {
    type = string
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/24"
  
}

variable "enable_dns_hostnames" {
    type = string
    default = "true"
  
}
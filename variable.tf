variable "aws_region" {
  type    = string
  default = "us-east-1"

}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

variable "ami" {
    type = string
    default = "ami-0030e4319cbf4dbf2"
  
}

variable "environment_type" {
  type    = string
  default = "dev"

}

variable "bucket_name" {
  type    = string
  default = "hari-bucket4747"

}
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

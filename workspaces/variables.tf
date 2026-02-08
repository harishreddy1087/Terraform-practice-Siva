# variable "regions" {
#   type    = string
#   default = "us-east-1"

# }

variable "instance_types" {
  type    = list(string)
  default = [ "t2.micro", "t3.micro", "t3.small" ]

}


variable "ami_id" {
  type    = string
  default = "ami-019715e0d74f695be"

}

variable "instance_count" {
    type = number
    default = 1
  
}

variable "instance_tags" {
    type = map(string)
    default = {
      "developer" = "hari"
      "project" = "hari_project"
      "environment" = "dev"
    }
  
}
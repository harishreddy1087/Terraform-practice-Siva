variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "sg_name" {
    type = string
  
}

variable "vpc_id" {
    type = string
  
}

variable "ingress_rules" {
    type = list(object({
      from_port = number
      to_port = number
      cidr_blocks = list(string)
      protocol = string

    }))
  
}
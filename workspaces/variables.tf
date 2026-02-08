variable "region" {
  type = string
  # here im not using the variables because by using this im learning the workspaces with indivdual env.tfvars
}

variable "instance_types" {
  type = list(string)

}


variable "ami_id" {
  type = string

}

variable "instance_count" {
  type = number

}

variable "instance_tags" {
  type = map(string)

}
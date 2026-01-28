#[]=== this is LIST
#{}=== map

variable "ami_id" {
    type = string
    default = "ami-0b6c6ebed2801a5cb"
    description = "using the ubuntu ami id"

}


variable "instance_id" {
    type = string
    default = "t2.micro"
    description = "using t2.micro"
  
}

variable "tags" {
    type = map
    default = {
        Name = "Terraform"
        project = "practice"
        environments = "PROD"
        application = "Backend"
        Terraform = "true"

    }
  
}

variable "sg_name" {
    default = "allow_ssh_terraform"
}

variable "sg_description" {
    default = "allow-port-22 for SSH"
  
}

variable "from_port" {
    type = number
    default = 22
  
}

variable "to_port" {
    type = number
    default = 22
  
}

variable "protocol" {
    default = "tcp"
  
}
variable "ingress_cidr" {
    type = list(string) # because it have string along with list
    default = [ "0.0.0.0/0" ]
  
}
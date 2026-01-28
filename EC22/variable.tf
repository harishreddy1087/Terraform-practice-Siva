#[]=== this is LIST
#{}=== map

# Which one should you use?
# Use string ======= for things like AMI IDs, Instance IDs, or Names.

# Use list(string) ========== for Availability Zones or Subnet IDs.

# Use map(string)=================  for Tags (like your previous example).

# Use object if you want to pass a whole "profile" of information to a module.

# Requirement	Type to Use
# Just a name or ID	string
# How many instances?	number
# Enable monitoring?	bool
# Multiple security groups	list(string)
# Environment-specific IDs	map(string)
# Complex server setup	object

variable "ami_id" {
    type = string
    default = "ami-0b6c6ebed2801a5cb"
    description = "using the ubuntu ami id"

}


variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "using t2.micro"

    validation {
    condition     = contains(["t2.micro", "t3.micro", "t3.small"], var.instance_type)
    error_message = "Only free-tier or small instances are allowed."
  }
  
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
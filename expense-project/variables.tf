variable "instance_names" {
    #Type: list(string)
     #Purpose: This is an ordered list of names.
    type = list(string)
    default = [ "DB", "Frontend", "Backend" ]
  
}

# Type: map
# Purpose: This is a collection of key-value pairs
# How it’s used: These are details that apply to every resource. 
# Instead of typing "project = expense" over and over for every server, you store it here once and "inject" it into all your resources.

variable "common_tags" {
    type = map(string)
    default = {
        project = "expense"
        Environment = "dev"
        terraform = "true"
    }

}
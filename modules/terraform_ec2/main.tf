resource "aws_instance" "hari_instance" { 
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
      Name = var.instance_name
      Environment = var.environment_type
    }
    
  
}
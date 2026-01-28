

# in this im using the variables

resource "aws_security_group" "allow_ssh" {
    name = var.sg_name
    description = "var.sg_description"

    egress {  # egress means outbound rules that is outgoing traffic
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    # When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    ingress {  # egress means outbound rules that is incoming traffic
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.protocol # # Use "tcp" instead of "-1"
    # When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
    cidr_blocks      = var.ingress_cidr
    ipv6_cidr_blocks = ["::/0"]
  } 

   tags = var.tags
}



# crerating EC2 instance with name terra-ec2
resource "aws_instance" "terra-ec2" {
  ami = "var.ami_id"
  instance_type = "var.instance_id"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id] # we are using already created the SG which i have crerated above before the instance creation.

  tags =var.tags
}

# for creating the EC2 Instance with following the for_each loop 
# by defualt when we use the for_each it will generate the each.key


# 1.creating the Security groups

resource "aws_security_group" "allow_ssh_terraform" {
  description = "allow-port-22 for SSH"

  egress { # egress means outbound rules that is outgoing traffic
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress { # egress means outbound rules that is incoming traffic
    from_port = 22
    to_port   = 22
    protocol  = "tcp" # # Use "tcp" instead of "-1"
    # When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-SG"
  }

}

# crerating EC2 instance with name terra-ec2
resource "aws_instance" "terra-ec2" {
  for_each               = var.instances # getting the values from variable.tf
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = each.value                               # this will fetech the value from variable.tf
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id] # we are using already created the SG which i have crerated above before the instance creation.

  tags = {
    Name = each.key
  }
}





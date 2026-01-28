# for creating the EC2 Instance we have follow the below steps

# 1. create the Security groups
# 2. VPC
# 3. subnets


# 1.creating the Security groups

resource "aws_security_group" "allow_ssh_terraform" {
    description = "allow-port-22 for SSH"

    egress {  # egress means outbound rules that is outing traffic
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    # When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    ingress {  # egress means outbound rules that is outing traffic
    from_port        = 22
    to_port          = 22
    protocol         = "tcp" # # Use "tcp" instead of "-1"
    # When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } 

   
}




# below is for practcing the creation of the multiple instances at a timw with using count and count.index



resource "aws_security_group" "allow_ssh_terraform" {
    description = "allow-port-22 for SSH"

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
    from_port        = 22
    to_port          = 22
    protocol         = "tcp" # # Use "tcp" instead of "-1"
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
  ami = "ami-0b6c6ebed2801a5cb"
  # creating the multiple instances at a time
  count = 3 #create three similar EC2 instances
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id] # we are using already created the SG which i have crerated above before the instance creation.

  tags = {
    #by using the count.index it will fetch the instance names from the variables
    Name = var.instance_names[count.index]
  }
}

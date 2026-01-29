
# in this we can practice the common tags and merge function. and outputs


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

#    tags = {
#     Name = "allow-SG"
#   }
   
}

# crerating EC2 instance with name terra-ec2
resource "aws_instance" "expense" {
  ami = "ami-0b6c6ebed2801a5cb"
  # here we arwe using the length function because we are not sure how many instances we are creating
  count = length(var.instance_names)
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id] # we are using already created the SG which i have crerated above before the instance creation.

# here im merging the commonn tags which used for overall services and name also same.
# merge() combines the unique name with the common tags
  tags = merge(
    var.common_tags,
    {
        Name = var.instance_names[count.index]

    }
  )
  
}

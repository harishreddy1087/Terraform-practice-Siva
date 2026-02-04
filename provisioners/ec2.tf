# for practising the provisioners
# provisioners are start working while the resources creations time only
# here practising the local-exec and remote-exec


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

  ingress { # egress means outbound rules that is incoming traffic
    from_port = 80
    to_port   = 80
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
resource "aws_instance" "aha-ec2" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t2.micro"
  key_name               = "practice"                          # added only for practie the provisioners.
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id] # we are using already created the SG which i have crerated above before the instance creation.

  tags = {
    Name = "terra-ec2"
  }
  # by using this local exec we are sending the msg like task completed and stroing the public ip as file
  provisioner "local-exec" {
    command = "echo provisioning completd && echo ${self.public_ip} >> public_ips.txt"

  }

  provisioner "remote-exec" {
    inline = [
        # Wait for the cloud-init/auto-updates to finish and release the lock
      "while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do echo 'Waiting for other software managers to finish...'; sleep 5; done",
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/Harish Reddy/Downloads/practice.pem") # Path to your local .pem file
      host        = self.public_ip
    }

  }
}





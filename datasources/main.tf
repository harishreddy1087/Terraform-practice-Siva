data "aws_ami" "ubuntu-os" {
  most_recent = true
  owners      = ["099720109477"] # # Canonical's ID, not yours aws account id if in case you have the existing AMI you can use your AWS ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # # This pattern matches official Ubuntu 22.04 images

  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]

  }

}

resource "aws_instance" "data" {
  ami           = data.aws_ami.ubuntu-os.id # by using this we can fetech the AMI with out going to AWS
  instance_type = "t2.micro"

  tags = {
    Name = "hari-instance"
  }

}

# by this learning the workspaces concepts.


resource "aws_instance" "jems" {
  region        = var.region
  ami           = var.ami_id
  instance_type = var.instance_types[1] # by giving this instance will create with t3.micro
  count         = var.instance_count

  tags = merge(var.instance_tags, {
    # Name = "hari-${var.instance_tags["Environment"]}-instance${count.index}"
    Name = "hari-${terraform.workspace}-${count.index}" ## best command to use while using the workspace to avoid the confusion
  })


}
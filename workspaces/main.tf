resource "aws_instance" "jems" {
#   region        = var.regions
  ami           = var.ami_id
  instance_type = var.instance_types[1] # by giving this instance will create with t3.micro
  count = var.instance_count

  tags =merge(var.instance_tags, {
    Name = "hari-instance${count.index}"
  })


}
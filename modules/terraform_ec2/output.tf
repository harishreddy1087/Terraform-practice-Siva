output "instance_id" {
    value = aws_instance.hari_instance.id

}

output "EC2_Public_ip" {
    value = aws_instance.hari_instance.public_ip
  
}

output "EC2_Private_ip" {
    value = aws_instance.hari_instance.private_ip
  
}

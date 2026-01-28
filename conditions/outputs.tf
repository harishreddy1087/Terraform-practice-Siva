output "pubilc_ip" {
    value = aws_instance.terra-ec2.public_ip
  
}

output "private_ip" {
    value = aws_instance.terra-ec2.private_ip
  
}

output "ARN" {
    value = aws_instance.terra-ec2.outpost_arn
  
}
output "public_ip" {
  value = aws_instance.jems[0].public_ip # here im usisg the [0] because i want the public of the one instances because i have launched the 2instance
# if you gave [*] menas you will get the all the instances ips

}

output "instance1_private_ip" {
  value = aws_instance.jems[0].instance_state

}
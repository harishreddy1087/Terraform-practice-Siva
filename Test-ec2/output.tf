output "instance_id" {
  value = module.ec2_instance.instance_id # in root module dont have info for that we have to call it from module to root module

}

output "EC2_Public_ip" {
  value = module.ec2_instance.EC2_Public_ip

}

output "EC2_Private_ip" {
  value = module.ec2_instance.EC2_Private_ip

}

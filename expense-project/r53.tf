
# # the purpose of using the route53 is to store the records but here i dont have the domain.

# resource "aws_route53_record" "expense" {
#   count = length(var.instance_names)
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "www.example.com"
#   type    = "A"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
# }
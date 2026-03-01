resource "aws_security_group" "expense_sg" {
    name = var.sg_name
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
            from_port   = ingress.value["from_port"]
            to_port     = ingress.value["to_port"]
            protocol    = ingress.value["protocol"]
            cidr_blocks = ingress.value["cidr_blocks"]
        }
      
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        ## When you set the protocol to -1, 
    #you are telling AWS that this rule applies to every type of traffic, regardless of whether it is TCP, UDP, ICMP, or something else.
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }


    tags = {
      Name = "${var.project_name}-sg-${var.environment}"
    }
  
}
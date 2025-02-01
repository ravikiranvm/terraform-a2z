output "alb_dns_name" {
    value = aws_lb.web-server-alb.dns_name
    description = "The public IP of the web server"
}

output "asg_name" {
    value = aws_autoscaling_group.web-server-asg.name
    description = "The name of the autoscaling group"
}

output "alb_security_group_id" {
    value = aws_security_group.alb-sg.id
    description = "The ID of the security group for the ALB"
}


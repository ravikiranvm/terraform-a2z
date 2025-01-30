output "alb_dns_name" {
    value = aws_lb.web-server-alb.dns_name
    description = "The public IP of the web server"
}
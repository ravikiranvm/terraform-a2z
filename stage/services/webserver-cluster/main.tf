# ASG template with Ubuntu AMI in default VPC

resource "aws_launch_template" "web-server" {
    image_id = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web-server-sg.id]

    user_data = base64encode(templatefile("${path.module}/user-data.sh", {
        server_port = var.server_port
        db_address = data.terraform_remote_state.db.outputs.address
        db_port = data.terraform_remote_state.db.outputs.port
    }))

    lifecycle {
        create_before_destroy = true
    }

}

# Auto scaling group
resource aws_autoscaling_group "web-server-asg" {
    launch_template {
      id = aws_launch_template.web-server.id
    }

    vpc_zone_identifier = data.aws_subnets.default.ids
    min_size = 2
    max_size = 10
    target_group_arns = [aws_lb_target_group.web-server-tg.arn]
    health_check_type = "ELB"

    tag {
        key = "Name"
        value = "web-server"
        propagate_at_launch = true
    }

}

# Application load balancer config
resource "aws_lb" "web-server-alb" {
    name = "web-server-alb"
    load_balancer_type = "application"
    subnets = data.aws_subnets.default.ids
    security_groups = [aws_security_group.alb-sg.id]
}

# Listener for the ALB
resource aws_lb_listener "web-server-alb-listener" {
    load_balancer_arn = aws_lb.web-server-alb.arn
    port = 80
    protocol = "HTTP"

    # by default return a simple 404 page
    default_action {
      type = "fixed-response"

      fixed_response {
        content_type = "text/plain"
        message_body = "404: Page not found"
        status_code = "404"
      }
    }
}

# Listener rule for the ALB
resource "aws_lb_listener_rule" "asg-rule" {
    listener_arn = aws_lb_listener.web-server-alb-listener.arn
    priority = 100

    condition {
        path_pattern {
            values = ["*"]
        }
    }

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.web-server-tg.arn

    }
}

# Target group for the ALB
resource "aws_lb_target_group" "web-server-tg" {
    name = "web-server-tg"
    port = var.server_port
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default.id

    health_check {
      path = "/"
      protocol = "HTTP"
      matcher = "200"
      interval = 15
      timeout = 3
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
}

# SG for the ALB
resource "aws_security_group" "alb-sg" {
    name = "alb-sg"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Security group for the above EC2 instance
resource "aws_security_group" "web-server-sg" {
    name = "web-server-sg"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Query the db secrets from remote state
data "terraform_remote_state" "db" {
    backend = "s3"

    config = {
        bucket = "terraform-stat-25v001"
        key    = "stage/data-stores/mysql/terraform.tfstate"
        region = "us-east-1"
    }
}

# Query the VPC data 
data "aws_vpc" "default" {
    default = true
}

# Query the subnets data
data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

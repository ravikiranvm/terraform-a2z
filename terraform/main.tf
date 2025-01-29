# EC2 Instance with Ubuntu AMI in default VPC

resource "aws_instance" "web-server" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web-server-sg.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true  #On change of user_data, instance will be replaced
    tags = {
        Name = "web-server"
    }
}

# Security group for the above EC2 instance
resource "aws_security_group" "web-server-sg" {
    name = "web-server-sg"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


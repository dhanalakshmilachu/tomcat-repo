provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "tomcat_sg" {
  name = "tomcat-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tomcat_ec2" {
  ami                    = "ami-0fa91bc90632c73c9"
  instance_type          = "t3.micro"
  key_name               = "new-key"
  vpc_security_group_ids = [aws_security_group.tomcat_sg.id]

  user_data = file("userdata.sh")

  tags = {
    Name = "Tomcat-EC2"
  }
}

output "public_ip" {
  value = aws_instance.tomcat_ec2.public_ip
}


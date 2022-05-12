terraform {
  cloud {
    organization = "nio-terraform"

    workspaces {
      name = "nio-dev"
    }
  }
}





resource "aws_instance" "jenkins" {
  ami                    = "ami-0022f774911c1d690"
  instance_type          = "t2.micro"
  key_name               = "devopskey"
  vpc_security_group_ids = [aws_security_group.allow_access.id]


  tags = {
    Name = "jenkins-server"
  }
}


resource "aws_security_group" "allow_access" {
  name        = "allow_access"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0425cc6784c017227"

  ingress {
    description = "ssh from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "jenkins from public"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
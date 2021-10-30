provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "web" {
  ami                    = "ami-058e6df85cfc7760b" // Amazon Linux2
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh.tpl", { // Template File
    f_name = "Annie"
    l_name = "Koshy"
    names  = ["Sravani", "Aneez", "Umar", "Alwin", "ganendra", "Sreyas", "Sainath"]
  })

  tags = {
    Name  = "WebServer Built by Terraform"
    Owner = "Annie"
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my WebServer"

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Annie Koshy"
  }
}

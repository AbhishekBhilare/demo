terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
  }
}
resource "aws_security_group" "aws_ec2_sg" {
  name        = "${var.security_groups_name}"
  description = "Allows traffic"


  dynamic "ingress" {
    for_each = var.from_port
    content {
      from_port   = ingress.value
      to_port     = element(var.to_port, index(var.from_port, ingress.value))
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "${var.key-name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}


resource "aws_instance" "ec2" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = [aws_security_group.aws_ec2_sg.id]
  key_name = aws_key_pair.deployer.id
  count = var.no-of-instance

  tags = {
    Name = "${var.instance-name}"
  }
}

# <block_type> <resource_type> <resource_name> {
#
#   
#
#}


provider "aws" {
  region = "ap-south-1"
}



resource "aws_instance" "my-instance" {
    ami = "ami-006935d9a6773e4ec"
    key_name = "b6"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.my-sg.id ]
    depends_on = [ aws_security_group.my-sg ]
    tags = {
        Name = "my-demo-instance"
    }
}

resource "aws_security_group" "my-sg" {
  name        = "all-allow-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0a4a01f892d7dd813"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

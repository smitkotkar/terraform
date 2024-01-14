provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my-instance" {
    ami = "ami-0c0b74d29acd0cd97"
    key_name = "n.virginia"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-0541cd9dc925f1652"]  
}


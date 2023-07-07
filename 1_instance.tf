provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "my-instance" {
    ami = "ami-0d1c47ab964ae2b87"
    key_name = "ohio"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-00c1edbd5605281ea"]
}
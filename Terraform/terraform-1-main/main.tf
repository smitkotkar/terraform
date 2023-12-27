# we have to execute this main.tf 

provider "aws" {
  region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "terraform-backend-smit"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = module.vpc_module.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

module "vpc_module" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    project = var.project
    env = var.env
    private_subnet_cidr = var.private_cidr
    public_subnet_cidr = var.public_cidr
}           


module "lb_module" {
    source = "./modules/LoadBalancer"
    ami_id = var.ami_id
    instance_type = var.instance_type
    project = var.project
    key_pair = var.key_pair
    sg_ids = [aws_security_group.allow_http.id]
    subnet_ids = [ module.vpc_module.subnet_1_id,  module.vpc_module.subnet_2_id]
}

#
# tf init
# tf plan
# tf apply --auto-approve
variable "vpc_cidr" {
    default = "10.10.0.0/16"
}

variable "project" {
    default = "SMITKOTKAR_Company"
}

variable "env" {
    default = "main"
}

variable "private_cidr" {
    default = "10.10.0.0/20"
}

variable "public_cidr" {
    default = "10.10.16.0/20"
} 

variable "ami_id" {
    default = "ami-04823729c75214919"
}

variable "instance_type" {
    default = "t2.micro"
}
variable "key_pair" {
    default = "N.Virginia"
}

# Here we are creating only VPC module
resource "aws_vpc" "cbz_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project}-vpc"
        Env = var.env    #main
    }
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.cbz_vpc.id
    cidr_block = var.private_subnet_cidr
    tags = {
        Name = "${var.project}-private_subnet_1"
        Env = var.env      #main
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.cbz_vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project}-public_subnet_2"
        Env = var.env
    }
}
# to execute above module, we need Provider Blocks
# we need to mention out side the modules directory as main.tf in which we write module

resource "aws_internet_gateway" "cbz_igw" {
    vpc_id = aws_vpc.cbz_vpc.id
    tags = {
        Name = "${var.project}-igw"
        Env = var.env
    }
}

resource "aws_default_route_table" "cbz_default_route_table" {
    default_route_table_id = aws_vpc.cbz_vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.cbz_igw.id
    }
    tags = {
        Env = var.env
    }
}

# we have to execute outer main.tf file present out side the modules directory
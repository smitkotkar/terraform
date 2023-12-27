output "demo" {
    value = "VPC CREATED"
}

output "subnet_1_id" {
    value = aws_subnet.public_subnet_1.id
}
output "subnet_2_id" {
    value = aws_subnet.public_subnet_2.id
}
output "vpc_id" {
    value = aws_vpc.cbz_vpc.id
}

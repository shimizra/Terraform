output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.public_2.id
}

output "private_subnet_1_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.private_1.id
}

output "private_subnet_2_id" {
  description = "The ID of the second private subnet"
  value       = aws_subnet.private_2.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  value       = aws_vpc.main.cidr_block
}

output "availability_zone_1" {
  description = "The first availability zone for public subnets"
  value       = data.aws_availability_zones.available.names[0]
}

output "availability_zone_2" {
  description = "The second availability zone for public subnets"
  value       = data.aws_availability_zones.available.names[1]
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.private_ec2.id
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.private_ec2.private_ip
}

output "private_ec2_public_ip" {
  value = aws_instance.private_ec2.subnet_id
  description = "The public IP of the EC2 instance"
}


# EC2 Instance in Private Subnet

resource "aws_security_group" "private_sg" {
  name        = "private-ec2-sg"
  description = "Security group for EC2 in private subnet"
  # vpc_id      = aws_vpc.main.id
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "private_ec2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  #subnet_id       = aws_subnet.private_1.id
  subnet_id       = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags            = local.common_tags
}

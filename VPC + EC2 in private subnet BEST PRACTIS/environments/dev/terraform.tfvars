# vpc ---------------------------------------------------

aws_region          = "us-east-1"
vpc_cidr_block      = "10.0.0.0/16"
public_subnet_cidr_1 = "10.0.1.0/24"
public_subnet_cidr_2 = "10.0.2.0/24"
private_subnet_cidr_1 = "10.0.3.0/24"
private_subnet_cidr_2 = "10.0.4.0/24"

# ec2 ---------------------------------------------------

ami_id              = "ami-0453ec754f44f9a4a"  # Default Amazon Linux AMI free tear
instance_type       = "t2.micro"

# tags ---------------------------------------------------

environment         = "dev" 
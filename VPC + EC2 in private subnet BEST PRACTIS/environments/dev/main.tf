
module "vpc" {
  source = "../../modules/VPC"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr_1 = var.public_subnet_cidr_1
  public_subnet_cidr_2 = var.public_subnet_cidr_2
  private_subnet_cidr_1 = var.private_subnet_cidr_1
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  environment       = var.environment
}


module "ec2" {
  source            = "../../modules/EC2"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_1_id
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  environment       = var.environment
}

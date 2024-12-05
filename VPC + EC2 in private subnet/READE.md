# Terraform AWS VPC Deployment + ec2 in privat subnet

This project sets up a VPC in AWS with the following resources:

- **2 Public Subnets**
- **2 Private Subnets**
- **1 NAT Gateway**
- **1 Internet Gateway**
- **Routing Tables**
- **1 EC2 machine in a private subnet**

## How to use:

1. Clone this repository.
2. Run `terraform init` to initialize the configuration.
3. Customize the variables in `terraform.tfvars`.
4. Run `terraform apply` to apply the configuration.
5. Verify the resources are created in AWS.

need to configure new or dynamic ami_id:

1)
ami_id              = "ami-0453ec754f44f9a4a"  # Default Amazon Linux AMI free tear
this one id already in my vpc.

2)
key_name      = "my-key-pair" # Name of the key pair in AWS
now is not configured, which means that no pem file for ssh -i, so no ssh connect.

# Terraform AWS VPC Deployment

This project sets up a VPC in AWS with the following resources:

- **2 Public Subnets**
- **2 Private Subnets**
- **1 NAT Gateway**
- **1 Internet Gateway**
- **Routing Tables**

## How to use:

1. Clone this repository.
2. Run `terraform init` to initialize the configuration.
3. Customize the variables in `terraform.tfvars`.
4. Run `terraform apply` to apply the configuration.
5. Verify the resources are created in AWS. You can modify the backend.tf if u want other s3 for store state.

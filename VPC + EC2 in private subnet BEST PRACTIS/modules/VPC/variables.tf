
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.0.4.0/24"
}


# Tags ------------------------------------

variable "devops_name" {
  description = "DevOps Name"
  type        = string
  default     = "Shimon"
}

variable "generated_by" {
  description = "Generated By"
  type        = string
  default     = "Terraform"
}

variable "scope" {
  description = "Scope of the resources"
  type        = string
  default     = "for deploying OpenVPN"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "Shimon Mizrahi"
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}

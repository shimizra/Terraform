variable "save_local" {
  type        = bool
  description = "Save the private key to a local file"
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "Vpc ID to use to deploy the instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to deploy the instance"
}

variable "profile" {
  type        = string
  description = "Profile to use"
}

variable "region" {
  type        = string
  description = "Region to deploy"
}
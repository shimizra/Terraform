variable "private_key_pair_name" {
  type        = string
  description = "Private key pair name"
  default     = "openvpn"
}

variable "save_local" {
  type        = bool
  description = "Save the private key to a local file"
  default     = false
}

variable "save_to_cloud" {
  type        = bool
  description = "Save the private key in SecretsManager"
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

variable "allow_access_to_all" {
  type        = bool
  description = "Allow open access to 0.0.0.0/0 subnet"
  default     = false
}


variable "allow_access_to_self" {
  type        = bool
  description = "Allow open access to deployer ip subnet"
  default     = true
}

variable "sg_name" {
  type        = string
  description = "Security group name"
  default     = "openvpn"
}

variable "instance_type" {
  type        = string
  description = "Instance type, check openvpn for recommendations (must fit amount of users)"
  default     = "t3.large"
}

variable "instance_name" {
  type        = string
  description = "Instance name"
  default     = "openvpn"
}

variable "open_vpn_starting_user" {
  type        = string
  description = "Default no pass user"
  default     = "openvpn"
}

variable "profile" {
  type        = string
  description = "Profile to use"
}
variable "region" {
  type        = string
  description = "region to use"
}

variable "allow_openvpn_admin_access" {
  type        = list(string)
  description = "list of ip address you want to open in the openvpn security group"
  default     = ["94.188.186.150/32"]
}

variable "allow_openvpn_connect" {
  type        = list(string)
  description = "list of allowing ip address for connect to openvpn"
  default     = ["0.0.0.0/0"]
}
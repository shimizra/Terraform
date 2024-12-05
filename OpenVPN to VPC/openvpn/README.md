# OpenVPN
Self managed OpenVPN, terraform code to create an open vpn instance.  
This also implements a tool to manage the users of the OpenVPN.  

Inside /home/ubuntu folder there will be a file called openvpn-install.sh.  
This script helps you manage OpenVPN.  
Moreover, the instance will listen on port 80 to show the connected users.  

## Requirements
 
| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.3 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.4 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_http"></a> [http](#provider\_http) | ~> 3.3 |
| <a name="provider_local"></a> [local](#provider\_local) | ~> 2.4 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.open_vpn_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.openvpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_secretsmanager_secret.ssh_key_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.ssh_key_content](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.openvpn_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_inbound_to_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_inbound_to_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_openvpn_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.configuration_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [local_file.ssh_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [terraform_data.install_openvpn](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [tls_private_key.key_pair](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ubuntu_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_access_to_all"></a> [allow\_access\_to\_all](#input\_allow\_access\_to\_all) | Allow open access to 0.0.0.0/0 subnet | `bool` | `false` | no |
| <a name="input_allow_access_to_self"></a> [allow\_access\_to\_self](#input\_allow\_access\_to\_self) | Allow open access to deployer ip subnet | `bool` | `true` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Instance name | `string` | `"openvpn"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type, check openvpn for recommendations (must fit amount of users) | `string` | `"t3.large"` | no |
| <a name="input_open_vpn_starting_user"></a> [open\_vpn\_starting\_user](#input\_open\_vpn\_starting\_user) | Default no pass user | `string` | `"openvpn"` | no |
| <a name="input_private_key_pair_name"></a> [private\_key\_pair\_name](#input\_private\_key\_pair\_name) | Private key pair name | `string` | `"openvpn"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Profile to use | `string` | n/a | yes |
| <a name="input_save_local"></a> [save\_local](#input\_save\_local) | Save the private key to a local file | `bool` | `false` | no |
| <a name="input_save_to_cloud"></a> [save\_to\_cloud](#input\_save\_to\_cloud) | Save the private key in SecretsManager | `bool` | `false` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Security group name | `string` | `"openvpn"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to deploy the instance | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Vpc ID to use to deploy the instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_description"></a> [ami\_description](#output\_ami\_description) | Ami description |
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | Ami Id |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Instance id |
| <a name="output_instance_private_ip"></a> [instance\_private\_ip](#output\_instance\_private\_ip) | Instance private ip to add to SG |
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | AWS key pair name |
| <a name="output_key_pair_arn"></a> [key\_pair\_arn](#output\_key\_pair\_arn) | AWS key pair arn |
| <a name="output_key_pair_id"></a> [key\_pair\_id](#output\_key\_pair\_id) | AWS key pair id |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | Private key pem |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | Public key pem |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | Secret manager id |
| <a name="output_server_ip"></a> [server\_ip](#output\_server\_ip) | Server IP |
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | Security group id |
| <a name="output_ssh_command"></a> [ssh\_command](#output\_ssh\_command) | SSH command for convenience |

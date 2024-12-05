# Public key output
output "public_key" {
  value       = tls_private_key.key_pair.public_key_pem
  description = "Public key pem"
  sensitive   = true
}

# Private key output

output "private_key" {
  value       = tls_private_key.key_pair.private_key_pem
  sensitive   = true
  description = "Private key pem"
}

output "key_pair_id" {
  value       = aws_key_pair.key_pair.id
  description = "AWS key pair id"
}


output "key_pair_arn" {
  value       = aws_key_pair.key_pair.arn
  description = "AWS key pair arn"
}


output "key_name" {
  value       = aws_key_pair.key_pair.key_name
  description = "AWS key pair name"
}

output "server_ip" {
  value       = aws_eip.open_vpn_ip.public_ip
  description = "Server IP"
}

output "sg_id" {
  value       = aws_security_group.openvpn_sg.id
  description = "Security group id"
}

output "instance_id" {
  value       = aws_instance.openvpn.arn
  description = "Instance id"
}

output "ssh_command" {
  description = "SSH command for convenience"
  value       = var.save_local ? "ssh -i ${aws_key_pair.key_pair.key_name}.pem ubuntu@${aws_eip.open_vpn_ip.public_ip}" : null
}

output "ami_id" {
  value       = data.aws_ami.ubuntu_latest.id
  description = "Ami Id"
}

output "ami_description" {
  value       = data.aws_ami.ubuntu_latest.description
  description = "Ami description"
}

output "secret_id" {
  value       = var.save_to_cloud ? aws_secretsmanager_secret.ssh_key_secret[0].id : null
  description = "Secret manager id"
}

output "instance_private_ip" {
  value       = "${aws_instance.openvpn.private_ip}/32"
  description = "Instance private ip to add to SG"
}
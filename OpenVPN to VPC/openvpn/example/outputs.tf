output "openvpn" {
  value     = module.open_vpn.private_key
  sensitive = true
}
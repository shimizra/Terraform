module "open_vpn" {
  source              = "../"
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  save_local          = var.save_local
  allow_access_to_all = true
  profile             = var.profile
  region              = var.region
}
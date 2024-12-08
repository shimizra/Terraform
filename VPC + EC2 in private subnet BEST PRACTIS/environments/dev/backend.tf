terraform {
  backend "s3" {
    bucket = "new-vpc-for-terraform-state" 
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

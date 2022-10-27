provider "hcp" {}

provider "aws" {
  region = var.region
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "ubuntu-nginx"
  channel     = "production"
} 


data "hcp_packer_image" "ubuntu_nginx" {
  bucket_name    = "ubuntu-nginx"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = var.region
}

resource "aws_instance" "app_server" {
  ami           = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id
  instance_type = "t2.micro"
  tags = {
    Name = "acme-demo-app"
  }
}

output "ubuntu_iteration" {
  value = data.hcp_packer_iteration.ubuntu
}

output "ubuntu_nginx_apsoutheast2" {
  value = data.hcp_packer_image.ubuntu_nginx
}

output "ubuntu_nginx_region" {
  value = data.hcp_packer_image.region
}
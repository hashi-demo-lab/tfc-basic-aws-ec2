terraform {
  required_version = ">= 1, < 2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.47.0"
    }
  }

  cloud {
    organization = "demo-lab-hashicorp"
  }
}

provider "hcp" {}

provider "aws" {
  region = var.region
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "aws-ubuntu-nginx"
  channel     = "production"
}


data "hcp_packer_image" "ubuntu_nginx" {
  bucket_name    = "aws-ubuntu-nginx"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = var.region
}

resource "aws_instance" "app_server" {
  ami                    = data.hcp_packer_image.ubuntu_nginx.cloud_image_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_pub1
  vpc_security_group_ids = var.sg_attach

  user_data = var.user_data

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
  value = data.hcp_packer_image.ubuntu_nginx.region
}
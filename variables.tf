variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "subnet_pub1" {
  description = "Public Subnet 1"
  default     = "subnet-01a543e54f9331473"
}

variable "sg_attach" {
  type        = list(any)
  description = "Security Groups to attach"
  default     = ["sg-03f7982a72a0ab724", "sg-03c5de6a05e835a26"]
}

variable "instance_type" {
  type = string
  description = "aws instance type"
  default = "t2.micro"  
}

variable "tags" {
  type = map(string)
  description = "aws resource tags"
  default = {
    Name = "acme-demo-app"
  }
}

variable "user_data" {
  type    = string
  default = <<-EOF
    #cloud-config
    runcmd:
    - cd /tmp
    - git clone https://github.com/hashicorp-demo-lab/demo-static-content.git;
    - cd /var/www/html;
    - sudo cp -r /tmp/demo-static-content/. .;
    - sudo systemctl restart nginx;
    EOF
}
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

variable "user_data" {
  type    = string
  default = <<EOF
                #!/bin/bash
                cd /tmp
                git clone https://github.com/hashicorp-demo-lab/demo-static-content.git;
                cd /var/html/www;
                sudo cp -r /tmp/demo-static-content/. .;
                sudo systemctl restart nginx;
        EOF

}
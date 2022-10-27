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
  default = ["sg-03f7982a72a0ab724", "sg-03c5de6a05e835a26"]
}
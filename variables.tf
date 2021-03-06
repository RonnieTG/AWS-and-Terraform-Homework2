# VARIABLES #

variable "key_name" {
  default = "xxxxx"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "private_subnets" {
    type = list(string)
    default = ["10.10.0.0/24", "10.10.10.0/24"]
}

variable "public_subnets" {
    type = list(string)
    default = ["10.10.100.0/24", "10.10.200.0/24"]
}

variable "environment_tag" {
    default = "TF-2nd-HW"
}

variable "ubuntu_account_number" {
  default = "099720109477"
}
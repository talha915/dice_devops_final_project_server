variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "server_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "client_subnet_cidr" {
  default = "10.0.2.0/24"
}

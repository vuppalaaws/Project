variable "cidr-block" {
    description = "cidr_block range for the VPC"
    default = "10.0.0.0/16"
}

variable "public-subnet-cidr" {
  description = "cidr-block for public subnet1"
  default = "10.0.0.0/24"
}



variable "private-subnet-cidr" {
  description = "cidr-block for private subnet1"
  default = "10.0.2.0/24"
}



/***variable "key-name" {
  description = "Key file"
  default = "MYUSEA1"
}***/

variable "platform" {
  default = "Endpoint"
}

variable "env" {
  description = "Default Environment"
  default = "dev"
}

variable "OwnerContact" {
  description = "Default Owner Contact"
  default = "vuppala.aws@gmail.com"
}
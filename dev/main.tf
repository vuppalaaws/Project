###Provider

provider "aws" {
  region                  = "us-east-1"
}

#########Backend Configuration#########
terraform {
  backend "s3" {
    bucket                  = "praneeth_project"
    key                     = "statefiles/project"
    region                  = "us-east-1"
  }
}
module "project" {
  source = "../../modules/vpc"

  aws_region       = "us-east-1"
  OwnerContact     = "vuppala.aws@gmail.com"
  env              = "dev"
  vpc_cidr         = "10.0.0.0/16"
  platform         = "Endpoint"
  public_subnet1  = "10.0.1.0/24"
  private_subnet1          = "10.0.2.0/24"
  key_name  = "Endpoint"

}

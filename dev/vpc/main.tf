provider "aws" {
  region = "us-east-1"

}

terraform{
    backend "s3"{
      bucket = "praneeth-vuppala-project"
      key    = "praneeth-vuppala-project/s3"
      region = "us-east-1"
    }
}

module "project" {
  source = "../../modules/vpc"
   cidr-block =  "10.0.0.0/16"
   public-subnet-cidr =  "10.0.0.0/24"
   private-subnet-cidr =  "10.0.2.0/24"
   #key-name = "Endpoint"
   platform = "Endpoint"
   env  =  "dev"
   OwnerContact  =  "vuppala.aws@gmail.com"
}
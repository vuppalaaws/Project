terraform {
  backend "s3" {
    bucket  = "praneeth-vuppala-project"
    key     = "praneeth-vuppala-project/elasticbean"
    region  = "us-east-1"
    encrypt = "true"
  }
}



provider "aws" {
  region = "us-east-1"
}

module "beanstalk" {
  source = "../../modules/beanstalk/"

  #application_name    = "dev"
  #runtime_environment = "dev-test"
  

  
  product_name = "Endpoint"

  min_instances = "1"
  max_instances = "2"
  key_name      = "Endpoint"

  #release_train = "${var.release_train}"
  account_name = "Endpoint"

  vpc_id                 = "vpc-0c182dc2622b5116a"
  region                 = "us-east-1"
  ec2_subnet_ids         = "subnet-02ecb18a3ed2bf42f"
  elb_subnet_ids         = "subnet-047f01648b9eb120c"
  ec2_security_group_ids = "sg-0ada54aa1c738a4cb"
  #s3bucket               = "Endpoint-est-codepipeline"
  #elb_scheme             = "application"
 name = "myrepo"
  wait_for_ready_timeout = "10m"

  #solution_stack_name    = "${var.beanstalk_solution_stack_name}"
  ec2_instance_type = "t2.micro"

  beanstalk_service_role = "aws-elasticbeanstalk-service-role"

  beanstalk_ec2_role = "aws-elasticbeanstalk-ec2-role"
}

terraform {
  backend "s3" {
    bucket  = "praneeth-vuppala-project"
    key     = "praneeth-vuppala-project/codepipeline"
    region  = "us-east-1"
    encrypt = "true"
  }
}



provider "aws" {
  region = "us-east-1"
}

module "beanstalk" {
  source = "../../modules/codepipeline"

  region              = "us-east-1"
  application_name    = "tf-test-name"
  runtime_environment = "linux"
  account_id          = "912434197592"
  s3triggerbucket     = "build-trigger-test-codepipeline"
  s3objectkey         = "beanstalk.zip"
  pipelinename        = "praneeth-test"
}
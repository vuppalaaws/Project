data "aws_vpc" "target" {
  id = "${var.vpc_id}"
}

data "aws_elastic_beanstalk_solution_stack" "docker" {
  most_recent = true

  #name_regex = "^64bit Amazon Linux (.*)  Docker (.*)$"
  #name_regex = "^64bit Amazon Linux (.*) Multi-container Docker (.*)$"
  name_regex = "^64bit Amazon Linux (.*) running Docker (.*)$"
   
  
}

resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "tf-test-name"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_environment" "dev" {
  #name                = var.runtime_environment
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker.name

  #cname_prefix = var.runtime_environment

  wait_for_ready_timeout = var.wait_for_ready_timeout



  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = data.aws_vpc.target.id
  }

  # EC2 Subnets - should be private
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = var.ec2_subnet_ids
  }

  # ELB Subnets - public 
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = var.elb_subnet_ids
  }



  

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.beanstalk_ec2_role
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.ec2_instance_type
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.key_name
  }
setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.ec2_security_group_ids
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_instances
  }
   setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_instances
  }

  }

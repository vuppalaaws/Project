AWS services to build and deliver infrastructure at any scale we need thanks to DevOps tooling and automation.  In this exercise, we want you to use terraform and the tooling of your choice to accomplish the following tasks.  


1 VPC

1 Public Subnet

1 Elastic Beanstalk instance for Docker

Choose a container to deploy from the following:

https://hub.docker.com/_/postgres

https://hub.docker.com/_/kibana (note: you do not need to have data fed into Kibana, the requirement is only for the Kibana UI running on Elastic Beanstalk)

https://hub.docker.com/r/jenkins/jenkins

https://hub.docker.com/_/ghost

A simple script to deploy a single container from ECR to Elastic Beanstalk

Use OpsWorks and/or CodeBuild/CodePipeline


When you’re finished, you may submit the results as a git repository or as a zipped folder of the repository
==============================================================================================================================


Approach:  
       
      I haven choose approach of writing modules and parameterizing the environments with input variables, so that modules can be reused.

Requirements:

1.	By Analyzing the requirement, I have prepared the Architecture diagram on rough note and written all the required resources that need to be created for our infrastructure.
2.	I have listed over all resources that need to be created such as VPC, Subnets (both public & private), Route tables (public & private), Security Groups, Gateways (IGW, NAT), Elastic Beanstalk, Code Pipeline, ECR Repository and IAM Roles/Polices.
3.	I have used backend configuration S3 for storing my state files.
4.	I have created module by module and tested them at frequent intervals to make sure all my code works as expected.
5.	I have pulled Jenkins latest image and pushed to ECR.
6.	Written configuration Dockerrun.aws.json file which is stored in S3 and picked by Code pipeline 
7.	I have written shell script to authenticate and push image to ECR
8.	Deployed the code with Code pipeline and continuously gets deployed based on S3 Event triggers
9.	Provisioned the entire infrastructure through terraform.

Architecture:

1.	Provisioned the infrastructure in terraform by designing modules for beanstalk/Code pipeline/s3/vpc
2.	Parameterized in a way that we can use modules for any environment like dev/qa/prod. The input values for specific environment can be in separate folder and call modules as needed 
3.	Designed the dev environment for our requirement and provided parameter values in the main.tf file. 
4.	We have created IAM Roles/Polices to allow traffic between Elastic Beanstalk /EC2/ECR/CodePipelines.


List of Modules:
 
1.	vpc
2.	s3
3.	codepipeline
4.	beanstalk

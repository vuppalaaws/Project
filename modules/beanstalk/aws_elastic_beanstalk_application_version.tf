# define elastic beanstalk app version
# variable "version" {
#   type    = "string"
#   default = "0.1-SNAPSHOT"
# }
# resource "aws_elastic_beanstalk_application_version" "edm" {
#   name        = "multicontainer"
#   application = "${var.application_name}"
#   description = "Version latest of app"
#   bucket      = "${var.s3bucket}"
#   key         = "beanstalk.zip"
# }


module "s3" {
  source = "../../modules/s3"

  bucket = "praneeth-vuppala-project"
  region = "us-east-1"
  Name        = "My bucket"
  Environment = "Dev"
}
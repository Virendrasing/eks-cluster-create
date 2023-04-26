terraform {
  backend "s3" {
    bucket = "redmine-bucket-new"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}

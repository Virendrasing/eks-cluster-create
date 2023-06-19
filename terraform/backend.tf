terraform {
  backend "s3" {
    bucket = "redmine-bucket-new-1"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}

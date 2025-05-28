terraform {
  backend "s3" {
    bucket         = "s3-backend-statefile-demo-1"
    key            = "statefile-demo/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
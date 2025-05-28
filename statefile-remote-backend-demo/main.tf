provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "statefile-demo" {
  ami = "ami-0f9de6e2d2f067fca"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "statefile-demo" {
  bucket = "s3-backend-statefile-demo-1" 
}

resource "aws_dynamodb_table" "terraform_lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
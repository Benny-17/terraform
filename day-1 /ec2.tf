provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-0f9de6e2d2f067fca"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id = "subnet-08cf736e3f9ff7b5d"
    key_name = "demo-01"
}

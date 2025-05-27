provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0f9de6e2d2f067fca"
  instance_type_value = "t2.micro"
}
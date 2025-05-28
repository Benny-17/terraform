# Terraform EC2 Instance Example
This is a simple Terraform configuration to launch an **EC2 instance** in AWS using a single file (`main.tf`).

## 📄 What This File Does

The `ec2.tf` file:

- Connects to AWS using the provider block
- Launches an EC2 instance with the given:
  - AMI ID
  - Instance type (`t2.micro`)
  - Subnet ID
  - SSH key name (for access)


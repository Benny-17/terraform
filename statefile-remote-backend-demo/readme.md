# Terraform State File with Remote Backend (S3 + DynamoDB)

## 📌 Overview

This demo shows how to manage Terraform state using a remote backend, ensuring team-safe deployments with proper locking and consistency.

- **S3 Bucket**: Stores the `terraform.tfstate` file.
- **DynamoDB Table**: Provides locking to prevent concurrent changes.

## 🛠️ Files Used

- `main.tf`: Defines AWS provider, EC2 instance, S3 bucket, and DynamoDB table.
- `backend.tf`: Configures the remote backend.

---

## 🚀 Setup Instructions

### 1. Set Up Your Workspace

In this demo, GitHub Codespaces was used. You can use any environment where Terraform and AWS CLI are available.

### 2. Configure AWS CLI

Make sure AWS credentials are configured:

```bash
aws configure
```
### 3. Step-by-Step Execution
A. Apply Local Resources First
Run the following commands:

```bash
terraform init
terraform plan
terraform apply
```
This creates the EC2 instance, S3 bucket, and DynamoDB table.

B. Configure Remote Backend
Now that the required resources exist, create a backend.tf file:

```bash
terraform {
  backend "s3" {
    bucket         = "s3-backend-statefile-demo-1"
    key            = "statefile-demo/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
```
C. Reinitialize Terraform
```bash
terraform init
```
Terraform will prompt you to migrate the state to the remote backend (S3). Confirm when prompted.

D. Verify Remote State
To verify that the state is now stored remotely:

```bash
terraform show
```
Even after deleting the local .tfstate file, this command still works—proof that S3 holds the remote state.


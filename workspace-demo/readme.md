# Terraform Workspace Demo

This repository demonstrates how to use **Terraform workspaces** to manage multiple environments (like `dev`, `stage`, and `prod`) using a shared infrastructure codebase and isolated state files.

## 🚀 What This Demo Does

- Creates an EC2 instance using Terraform.
- Uses **Terraform workspaces** to switch between environments.
- Assigns different `instance_type` based on the current workspace:
  - `dev` → `t2.micro`
  - `stage` → `t2.medium`
  - `prod` → `t2.xlarge`

## ⚙️ How to Use

### 1. Clone the repo

```bash
git clone https://github.com/your-username/workspace-demo.git
cd workspace-demo
```
### 2. Initialize Terraform
```bash
terraform init
```
### 3. Create and switch to a workspace
```bash
terraform workspace new dev        # Or stage / prod
terraform workspace select dev
```
### 4. Apply the configuration
```bash
terraform plan
terraform apply
```
✅ Terraform will use the correct instance_type based on the workspace you select!

### 5. Verify the output
Check the AWS EC2 dashboard for the instance created with the expected type.

### 6. Clean up resources
```bash
terraform destroy
terraform workspace select default
terraform workspace delete dev
```
## 🧠 Key Concept: Workspace-Based Configuration
In main.tf, we use the terraform.workspace variable to dynamically assign instance types based on the current workspace:
```
instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
```
This allows one codebase to deploy different infrastructure per environment.

## 📝 Notes
This is a demo project to learn about Terraform workspaces.
For production environments, it's better to use separate backends or directories instead of workspaces alone.


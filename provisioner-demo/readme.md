# 🚀 Terraform Flask App Deployment on AWS EC2

This project demonstrates how to deploy a simple Flask application on an AWS EC2 instance using Terraform with **provisioners**.

---

## 🧱 Project Overview

This project includes:

- A **custom VPC** with public subnet
- An **Internet Gateway** and **Route Table** to allow internet access
- An **EC2 instance** running Ubuntu
- A **security group** to allow SSH (22) and HTTP (80)
- Terraform **provisioners** to:
  - Copy the `app.py` Flask file to EC2 (`file` provisioner)
  - Install Flask and start the app (`remote-exec` provisioner)

---

## 📁 File Structure

```bash
.
├── main.tf         # Terraform configuration
├── app.py          # Simple Flask app
└── README.md       # Project documentation
```
## 🔧 Prerequisites

Terraform installed

AWS account and credentials configured

SSH key pair (generate using ssh-keygen -t rsa)

## 🛠️ Setup Instructions

### 1. Clone the Repo
```bash
git clone https://github.com/yourusername/terraform-flask-ec2.git
cd terraform-flask-ec2
```
### 2. Generate SSH Key Pair
```bash
ssh-keygen -t rsa
ls -l ~/.ssh
```
Update main.tf with the correct public/private key path.

### 3. Initialize Terraform
```bash
terraform init
```
### 4. Plan & Apply Infrastructure
```bash
terraform plan
terraform apply
```
### 5. Access EC2 via SSH
```bash
ssh -i ~/.ssh/id_rsa ubuntu@<public_ip_address>
```
Check the Flask app:
```bash
ps -ef | grep python
curl http://<public_ip>
```
Or open in your browser:
http://<public_ip>

## 🧪Flask App Output
When accessed, the app should return:
```Hello from Terraform-provisioned EC2!```
## Tools Used
AWS EC2, VPC, Route Table, Subnet
Terraform
Flask (Python)

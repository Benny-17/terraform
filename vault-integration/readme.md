# 🔐 HashiCorp Vault + Terraform Integration Demo

This project demonstrates how to securely integrate **HashiCorp Vault** with **Terraform** to manage secrets such as API keys, passwords, and tokens.

## 🧠 Why Secrets Management?

Managing sensitive data securely is critical in any DevOps workflow. Hardcoding credentials in Terraform code or storing them in state files poses a security risk.

🔐 **HashiCorp Vault** helps by:
- Centrally managing secrets
- Dynamically generating credentials
- Providing fine-grained access control

This demo shows how to:
- Run Vault in dev mode
- Enable the KV secrets engine
- Create a Vault policy
- Use AppRole authentication
- Retrieve secrets in Terraform
- Use those secrets in AWS resources

---

---

## 🔧 Prerequisites

- AWS account with credentials
- Ubuntu EC2 instance
- Terraform (v1.0+)
- Vault installed and accessible
- Port `8200` open for Vault UI

---

## 🛠️ Setup Guide

### 1. Install Vault on Ubuntu

```bash
sudo apt update && sudo apt install gpg
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
```
### 2. Start Vault in Dev Mode
```bash
vault server -dev -dev-listen-address="0.0.0.0:8200"
```
Copy the VAULT_ADDR and root token printed in the output.

### 3. Enable KV Secrets Engine
```bash
vault secrets enable -path=kv kv-v2
vault kv put kv/test-secret username=admin password=supersecure
```
### 4. Create Vault Policy
```
# vault-policy.hcl
path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "auth/token/create" {
  capabilities = ["create", "read", "update", "list"]
}
```
```bash
vault policy write terraform vault-policy.hcl
```
### 5. Enable AppRole and Create Role
```bash
vault auth enable approle
```
```
vault write auth/approle/role/terraform \
  token_policies="terraform" \
  secret_id_ttl=10m \
  token_num_uses=10 \
  token_ttl=20m \
  token_max_ttl=30m \
  secret_id_num_uses=40
```
to generate role id
```
vault read auth/approle/role/terraform/role-id
```
to generate seccret id
```
vault write -f auth/approle/role/terraform/secret-id
```

Terraform Setup
1. Initialize Terraform Provider
```hcl
# terraform/main.tf

provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://<EC2_PUBLIC_IP>:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = "<role_id_from_vault>"
      secret_id = "<secret_id_from_vault>"
    }
  }
}
```
2. Read Secrets from Vault
```hcl
# main.tf continued

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test-secret"
}
```
3. Use Secrets in AWS Resource
```hcl
resource "aws_instance" "demo" {
  ami           = "ami-0f9de6e2d2f067fca"
  instance_type = "t2.micro"

  tags = {
    Name     = "vault-demo"
    Username = data.vault_kv_secret_v2.example.data["username"]
  }
}
```
4. Initialize and Apply
```bash
terraform init
terraform apply
```

### Best Practices
❌ Do not hardcode secrets in code

✅ Use .tfvars or environment variables for non-sensitive values

🔐 Use Vault policies to enforce least privilege

🛡️ Avoid using Vault dev mode in production


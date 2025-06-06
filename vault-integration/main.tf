provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://<EC2_PUBLIC_IP>:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
       role_id   = "<your_role_id>"
      secret_id = "<your_secret_id>"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0f9de6e2d2f067fca"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}


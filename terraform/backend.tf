# Values (bucket, prefix) are passed per environment:
#   terraform init -backend-config=envs/dev.backend.hcl -reconfigure
terraform {
  backend "gcs" {}
}

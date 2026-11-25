variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "environment" {
  description = "dev or prod"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be dev or prod."
  }
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "subnet_cidr" {
  type = string
}

variable "ssh_user" {
  type    = string
  default = "ansible"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519"
}

variable "ssh_source_ranges" {
  description = "Who may SSH in. Use your public IP, e.g. [\"1.2.3.4/32\"]"
  type        = list(string)
}

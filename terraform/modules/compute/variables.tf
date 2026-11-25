variable "name" {
  description = "Prefix for resource names (e.g. dev)"
  type        = string
}

variable "zone" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "ssh_public_key" {
  description = "Contents of the public key"
  type        = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

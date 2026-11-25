variable "name" {
  description = "Prefix for resource names (e.g. dev)"
  type        = string
}

variable "region" {
  type = string
}

variable "subnet_cidr" {
  description = "CIDR range of the subnet"
  type        = string
}

variable "ssh_source_ranges" {
  description = "IP ranges allowed to SSH (use your own IP/32)"
  type        = list(string)
}

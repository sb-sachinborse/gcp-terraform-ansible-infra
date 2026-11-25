locals {
  labels = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "gcp-terraform-ansible-baseline"
  }
}

module "network" {
  source = "./modules/network"

  name              = var.environment
  region            = var.region
  subnet_cidr       = var.subnet_cidr
  ssh_source_ranges = var.ssh_source_ranges
}

module "compute" {
  source = "./modules/compute"

  name           = var.environment
  zone           = var.zone
  machine_type   = var.machine_type
  network_id     = module.network.network_id
  subnet_id      = module.network.subnet_id
  ssh_user       = var.ssh_user
  ssh_public_key = trimspace(file(pathexpand(var.ssh_public_key_path)))
  labels         = local.labels
}

# Generate the Ansible inventory so Terraform and Ansible are connected.
resource "local_file" "ansible_inventory" {
  filename        = "${path.module}/../ansible/inventory/${var.environment}/hosts.ini"
  file_permission = "0644"
  content         = <<-EOT
    [web]
    ${module.compute.instance_name} ansible_host=${module.compute.external_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=${pathexpand(var.ssh_private_key_path)}

    [web:vars]
    env_name=${var.environment}
  EOT
}

output "web_external_ip" {
  value = module.compute.external_ip
}

output "web_url" {
  value = "http://${module.compute.external_ip}"
}

output "inventory_file" {
  value = local_file.ansible_inventory.filename
}

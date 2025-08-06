resource "local_file" "ansible_inventory" {
  content = templatefile("./output-templates/inventory.template", {
    nginx_ip              = azurerm_public_ip.nginx.ip_address,
    nginx_hostname        = var.admin_username,

    backend_ip            = azurerm_public_ip.backend.ip_address,
    backend_hostname      = var.admin_username,

    prom_grafana_ip       = azurerm_public_ip.prom-grafana.ip_address,
    prom_grafana_hostname = var.admin_username
  })
  filename = "../ansible/inventory"
}

resource "local_file" "backend_ip" {
  content = templatefile("./output-templates/backend.template", {
    ip = azurerm_network_interface.backend.private_ip_address
  })
  filename = "../ansible/vars/backend-ip.yaml"
}

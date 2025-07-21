resource "local_file" "ansible_inventory" {
  content = templatefile("./inventory.template", {
    ip = azurerm_public_ip.main.ip_address,
    hostname = var.admin_username
  })
  filename = "../ansible/inventory"
}

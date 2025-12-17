output "network_interface_ids" {
  value = { for k, v in data.azurerm_network_interface.nic : k => v.id }
}
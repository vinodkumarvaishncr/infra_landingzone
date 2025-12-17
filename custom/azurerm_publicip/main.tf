 resource "azurerm_public_ip" "pip" {
  for_each            = var.pip_info    
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = each.value.sku
}

output "public_ip_ids" {
  description = "IDs of all created public IPs"
  value = { for k, v in azurerm_public_ip.pip : k => v.id }
}
data "azurerm_subnet" "subnet" {
  //for_each = var.nic_config
  for_each = {
    for nic_name, nic in var.nic_config :
    nic_name => nic.ip_configuration["config1"]
  }
  //name                 = each.value.ip_configuration.subnet_name
  //virtual_network_name = each.value.ip_configuration.vnet_name
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  //resource_group_name  = each.value.resource_group_name
  resource_group_name  = var.nic_config[each.key].resource_group_name
}
resource "azurerm_virtual_machine" "vm" {
    for_each = var.vms
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  //network_interface_ids = data.azurerm_network_interface.nic[each.key].id
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = each.value.delete_os_disk_on_termination

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = each.value.delete_data_disks_on_termination

  storage_image_reference {
    publisher = each.value.storage_image_reference.publisher
    offer     = each.value.storage_image_reference.offer
    sku       = each.value.storage_image_reference.sku
    version   = each.value.storage_image_reference.version
  }
  storage_os_disk {
    name              = "${each.value.storage_os_disk.name}-osdisk"
    caching           = each.value.storage_os_disk.caching
    create_option     = each.value.storage_os_disk.create_option
    managed_disk_type = each.value.storage_os_disk.managed_disk_type
  }
  os_profile {
    computer_name  = each.value.os_profile.computer_name
    admin_username = each.value.os_profile.admin_username
    admin_password = each.value.os_profile.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = each.value.os_profile_linux_config.disable_password_authentication
  }
  tags = {
    environment = "staging"
  }
}
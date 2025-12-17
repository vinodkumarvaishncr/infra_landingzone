variable "vms" {
    type = map(object({
        name                  = string
        location              = string
        resource_group_name   = string
        nic_name = string
        network_interface_ids = string
        vm_size               = optional(string)

        delete_os_disk_on_termination = optional(bool)

   
        delete_data_disks_on_termination = optional(bool)

        storage_image_reference =optional(object({
            publisher = string
            offer     = string
            sku       = string
            version   = string
        }))
        storage_os_disk =optional(object({
            name = string
            caching     = string
            create_option       = string
            managed_disk_type   = string
        }))
        
        os_profile =optional(object({
            computer_name = string
            admin_username     = string
            admin_password       = string
            
        }))

        os_profile_linux_config =optional(object({
            disable_password_authentication = optional(bool)
             
        }))
         
        tags =optional(map(string)) 
        
    }))
}
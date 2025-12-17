variable "rg_list" {
    type = map(object({
                name = string
        location = string
        tags =  map(string)
    }))
}

 variable "storage_account_list" {
  description = "Map of storage accounts to create with optional advanced configuration"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    account_kind             = optional(string)
    cross_tenant_replication_enabled  = optional(bool)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    tags                              = map(string)

    # Optional blocks
    custom_domain = optional(list(object({
      name          = string
      use_subdomain = optional(bool)
    })))

    customer_managed_key = optional(list(object({
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
      user_assigned_identity_id = string
    })))

    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))

    delete_retention_policy = optional(list(object({
      days    = optional(number)
       
    })))

    restore_policy = optional(list(object({
      days = number
    })))

    versioning_enabled            = optional(bool)
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)

    container_delete_retention_policy = optional(list(object({
      days    = optional(number)
       
    })))
  }))
}

variable "vnet_list" {
    type = map(object({
            name                = string
            location            = string
            resource_group_name = string
            address_space       = list(string)
            dns_servers         = optional(list(string))
            
            tags =  map(string)
    }))
}

variable "subnet_list"  {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
     
  }))
}

variable "nic_config" {
  type = map(object(
    {
      name                = string
      location            = string
      resource_group_name = string
      ip_configuration = map(object({
          name                          = string
          subnet_id                     = string
          private_ip_address_allocation = string
          subnet_name                   = string
          vnet_name                     = string
      }))
      
    }
  )) 
}

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

variable "pip_info" {
  type = map(object(
    {
      name                = string
      location            = string
      resource_group_name = string
      allocation_method   = string
      sku                 = string
      
    }
  )) 
}

variable "kvs" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku_name                        = string
    enabled_for_disk_encryption     = optional(bool) # true
    soft_delete_retention_days      = optional(number)
    purge_protection_enabled        = optional(bool)
    enabled_for_deployment          = optional(bool) # bool optional true
    enabled_for_template_deployment = optional(bool) # bool optional true
    rbac_authorization_enabled      = optional(bool) # optional bool false
    public_network_access_enabled   = optional(bool) # optional bool default true
    tags                            = optional(map(string))

    network_acls = optional(map(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(string)
      virtual_network_subnet_ids = optional(list(string))

    })))
  }))
}
 variable "kv_secrets" {
    type = map(object({
  key_vault_secret_name         = string
  key_vault_secret_value        = string
  key_vault_name = string
  resource_group_name = string
    }))
}

variable "sql_server_list" {
    type = map(object({
            name                         = string
            resource_group_name          = string
            location                     = string
            version                      = string
            administrator_login          = string
            administrator_login_password = string
            minimum_tls_version          = string
    }))
}

variable "sql_database_list" {
    type = map(object({
            name         = string
            server_id    = string
            max_size_gb  = string
            sku_name     = string
            enclave_type = string
    }))
}
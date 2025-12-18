  rg_list = {
  rg1 = {
    name     = "vinod-rg11"
    location = "canadacentral"
    tags = {
      created_by = "terraform1"
      date       = "29oct"
    }
  }
  rg2 = {
    name     = "vinod-rg22"
    location = "east us"
    tags = {
      created_by = "terraform22"
      date       = "30oct"
    }
  }
}

storage_account_list ={
    "sa1" = {
        name                     = "storageaccountvinod1"
        resource_group_name      = "vinod-rg11"
        location                 = "east us"
        account_tier             = "Standard"
        account_replication_type = "GRS"

        account_kind = "StorageV2"
        cross_tenant_replication_enabled  = true 
        https_traffic_only_enabled = true 
        min_tls_version = "TLS1_2"
        allow_nested_items_to_be_public = true

        tags = {
            environment = "staging"
            created_by = "terraform1"
        }
        cors_rule = [{
            allowed_headers    = ["*"]
            allowed_methods    = ["GET", "POST", "HEAD"]
            allowed_origins    = ["*"]
            exposed_headers    = ["*"]
            max_age_in_seconds = 3600
          }]

          delete_retention_policy = [{
            days    = 7
            enabled = true
          }]

          versioning_enabled = true
          change_feed_enabled = true

          container_delete_retention_policy = [{
            days    = 10
            enabled = true
          }]
    }
     "sa2" = {
        name                     = "storageaccountvaish1"
        resource_group_name      = "vinod-rg22"
        location                 = "east us"
        account_tier             = "Standard"
        account_replication_type = "GRS"

        tags = {
            environment = "dev"
            created_by = "terraform2"
        }
    }
}

vnet_list = {
  "vnet1" = {
        name                = "vinod_vnetA"
        location            = "canadacentral"
        resource_group_name = "vinod-rg11"
        address_space       = ["10.0.0.0/16"]
        #dns_servers         = ["10.0.0.4", "10.0.0.5"]
        
        tags = {
            environment = "Production"
        }

    }
    "vnet2" = {
        name                = "vinod_vnetB"
        location            = "canadacentral"
        resource_group_name = "vinod-rg11"
        address_space       = ["10.1.0.0/16"]
        #dns_servers         = ["10.2.0.4", "10.2.0.5"]
        
        tags = {
            environment = "Production"
        }

    }
}

subnet_list = {
  "subnet1" = {
        name                = "vinod_vnetA_subnetA"
        resource_group_name = "vinod-rg11"
        virtual_network_name = "vinod_vnetA"
        address_prefixes     = ["10.0.0.0/28"]
         
    }
     "subnet2" = {
        name                = "vinod_vnetA_subnetB"
        resource_group_name = "vinod-rg11"
        virtual_network_name = "vinod_vnetA"
        address_prefixes     = ["10.0.1.0/28"]
         
    }
   
}

nic_config = {
  "nic1" ={
    name = "vinodnicA"
    location = "canadacentral"
    resource_group_name = "vinod-rg11"
    ip_configuration = {
      "config1" ={
        name = "nic1config1"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = ""
        subnet_name                   = "vinod_vnetA_subnetA"
        vnet_name                     = "vinod_vnetA"
      }
    }
  }
   "nic2" ={
    name = "vinodnicB"
    location = "canadacentral"
    resource_group_name = "vinod-rg11"
    ip_configuration = {
      "config1" ={
        name = "nic2config1"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = ""
        subnet_name                   = "vinod_vnetA_subnetB"
        vnet_name                     = "vinod_vnetA"
      }
    }
  }
  
}
vms = {
  "vm1" = {
            name                  = "vinod-vm1"
            location              = "canadacentral"
            resource_group_name   = "vinod-rg11"
            nic_name              = "vinodnicA" 
            network_interface_ids = ""
            vm_size               = "Standard_B2als_v2"

            # Uncomment this line to delete the OS disk automatically when deleting the VM
            delete_os_disk_on_termination = true

            # Uncomment this line to delete the data disks automatically when deleting the VM
            delete_data_disks_on_termination = true

            storage_image_reference = {
              publisher = "Canonical"
              offer     = "0001-com-ubuntu-server-jammy"
              sku       = "22_04-lts"
              version   = "latest"
            }
            storage_os_disk = {
              name              = "vinod-osdisk1"
              caching           = "ReadWrite"
              create_option     = "FromImage"
              managed_disk_type = "Standard_LRS"
            }
            os_profile = {
              computer_name  = "vinod-vm1"
              admin_username = "vinodadmin"
              admin_password = "Password1234!"
            }
            os_profile_linux_config = {
              disable_password_authentication = false
            }
            tags = {
              environment = "staging"
            }   

      }

      "vm2" = {
            name                  = "vinod-vm2"
            location              = "canadacentral"
            resource_group_name   = "vinod-rg11"
            nic_name            = "vinodnicB"  
            network_interface_ids = ""
            vm_size               = "Standard_D2s_v3"

            # Uncomment this line to delete the OS disk automatically when deleting the VM
            delete_os_disk_on_termination = true

            # Uncomment this line to delete the data disks automatically when deleting the VM
            delete_data_disks_on_termination = true

            storage_image_reference ={
              publisher = "Canonical"
              offer     = "0001-com-ubuntu-server-jammy"
              sku       = "22_04-lts"
              version   = "latest"
            }
            storage_os_disk ={
              name              = "vinod-osdisk2"
              caching           = "ReadWrite"
              create_option     = "FromImage"
              managed_disk_type = "Standard_LRS"
            }
            os_profile ={
              computer_name  = "vinod-vm2"
              admin_username = "vinodadmin"
              admin_password = "Password1234!"
            }
            os_profile_linux_config ={
              disable_password_authentication = false
            }
            tags ={
              environment = "staging"
            }

      }

  }

  pip_info = {
  "pip1" = {
    name = "vinod-pip1"
    resource_group_name     = "vinod-rg11"
    location = "canadacentral"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  "pip2" = {
    name = "vinod-pip2"
    resource_group_name     = "vinod-rg11"
    location = "canadacentral"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

# key vault

kvs = {
  kv1 = {
    name                        = "vinodkvaultnew"
    location                    = "canadacentral"
    resource_group_name         = "vinod-rg11"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 30
    purge_protection_enabled    = true
    sku_name                    = "standard"
    tags = {
      environment = "dev"
      owner       = "vinod"
      project     = "terraform-azure"
    }
  }
}

# key vault secret

kv_secrets = {
  kvs1 = {
    key_vault_secret_name  = "vm1-username"
    key_vault_secret_value = "azureuser"
    key_vault_name         = "vinodkvaultnew"
    resource_group_name    = "vinod-rg11"
  }

  kvs2 = {
    key_vault_secret_name  = "vm1-password"
    key_vault_secret_value = "Password@@12345"
    key_vault_name         = "vinodkvaultnew"
    resource_group_name    = "vinod-rg11"
  }

 

  
}

sql_server_list = {
  "server1" = {
    name                         = "vinod-sqlserver"
    resource_group_name          = "vinod-rg11"
    location                     = "canadacentral"
    version                      = "12.0"
    administrator_login          = "vinodadmin"
    administrator_login_password = "Password1234!"
    minimum_tls_version          = "1.2"
     
  }
}

sql_database_list = {
  "sqldatabase1" = {
    name         = "vinodmssqldatabase"
    server_id    = "sql"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
     
  }
}
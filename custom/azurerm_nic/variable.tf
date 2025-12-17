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

variable "public_ip_ids" {
  description = "Map of public IP IDs from pip module"
  type        = map(string)
}
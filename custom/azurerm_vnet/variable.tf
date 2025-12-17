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
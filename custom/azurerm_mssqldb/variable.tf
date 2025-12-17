variable "sql_database_list" {
    type = map(object({
            name         = string
            server_id    = string
            max_size_gb  = string
            sku_name     = string
            enclave_type = string
    }))
}
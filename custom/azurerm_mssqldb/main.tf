resource "azurerm_mssql_database" "Sqldatabase" {
  for_each     = var.sql_database_list
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.sql.id
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

   
}


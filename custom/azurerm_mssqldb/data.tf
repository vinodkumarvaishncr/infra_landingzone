data "azurerm_mssql_server" "sql" {
        name     = "vinod-sqlserver"
    resource_group_name = "vinod-rg11"
  
}

output "id" {
  value = data.azurerm_mssql_server.sql.id
}
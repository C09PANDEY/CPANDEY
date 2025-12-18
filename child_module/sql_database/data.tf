data "azurerm_mssql_server" "dbserver" {
  for_each = var.db

  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
}
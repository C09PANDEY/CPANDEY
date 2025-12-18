resource "azurerm_mssql_server" "dbserver" {
    for_each = var.dbserver

  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.admin_username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.admin_password[each.key].value
  minimum_tls_version          = each.value.minimum_tls_version
}


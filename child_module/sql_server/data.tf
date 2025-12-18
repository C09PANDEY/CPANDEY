data "azurerm_key_vault" "kv" {
    for_each = var.dbserver
    name = each.value.kv_name
    resource_group_name =  each.value.resource_group_name
}

data "azurerm_key_vault_secret" "admin_username" {
    for_each = var.dbserver
  name = each.value.administrator_login
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "admin_password" {
    for_each = var.dbserver
  name = each.value.administrator_login_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
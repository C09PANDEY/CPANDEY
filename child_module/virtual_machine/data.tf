data "azurerm_subnet" "subnet" {
    for_each = var.vm
  name = each.value.subnet_name
  resource_group_name = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}

data "azurerm_public_ip" "pip" {
    for_each = var.vm
    name = each.value.pip_name
    resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "kv" {
    for_each = var.vm
    name = each.value.kv_name
    resource_group_name =  each.value.resource_group_name
}

data "azurerm_key_vault_secret" "admin_username" {
    for_each = var.vm
  name = each.value.administrator_login
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "admin_password" {
    for_each = var.vm
  name = each.value.administrator_login_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
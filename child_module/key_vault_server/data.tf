data "azurerm_key_vault" "kv" {
    for_each = var.secret
    name = each.value.kv_name
    resource_group_name = each.value.resource_group_name  
}
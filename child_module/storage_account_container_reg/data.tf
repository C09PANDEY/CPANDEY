data "azurerm_storage_account" "stg" {
    for_each = var.asc
  name                = each.value.stg_name
  resource_group_name = each.value.resource_group_name
}
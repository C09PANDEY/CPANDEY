resource "azurerm_container_registry" "acr" {
  for_each = var.acr

  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  sku = each.value.sku
  admin_enabled = each.value.admin_enabled
}
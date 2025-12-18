resource "azurerm_storage_account" "stg" {
  for_each = var.stg

  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  account_tier = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  dynamic "network_rules" {
    for_each = each.value.network_rules
    content {
      default_action = network_rules.value.default_action
      bypass = network_rules.value.bypass
      ip_rules = network_rules.value.ip_rules
    }
  }
}
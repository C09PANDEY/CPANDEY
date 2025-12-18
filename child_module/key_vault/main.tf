data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
    for_each = var.kv
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
            "Get",
            "List",
      "Set",
      "Delete",
      "Recover",  # ✅ Required
      "Purge"     # ✅ Optional (if you want to purge secrets)
    ]

    storage_permissions = [
      "Get",
    ]
  }

  lifecycle {
  create_before_destroy = true
}

}
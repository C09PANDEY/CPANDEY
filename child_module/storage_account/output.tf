output "my_account" {
  value = {
    for k, sa in azurerm_storage_account.stg : k => sa.id
  }
}
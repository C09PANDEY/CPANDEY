output "resource_groups" {
  description = "List of created Resource Groups"
  value = {
    for k, rg in azurerm_resource_group.rg : k => {
      id       = rg.id
      name     = rg.name
      location = rg.location
    }
  }
}

output "rg_name" {
  value = { for k, v in azurerm_resource_group.rg : k => v.name }
}

output "rg_id" {
  value = { for k, v in azurerm_resource_group.rg : k => v.id }
}

output "rg_location" {
  value = { for k, v in azurerm_resource_group.rg : k => v.location }
}

output "rg_tags" {
  value = { for k, v in azurerm_resource_group.rg : k => v.tags }
}
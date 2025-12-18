resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aks

  name = each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  dns_prefix = each.value.dns_prefix

  dynamic "default_node_pool" {
    for_each = each.value.default_node_pool
    content {
      name = default_node_pool.value.name
      node_count = default_node_pool.value.node_count
      vm_size = default_node_pool.value.vm_size
    }
  }
    identity {
    type = "SystemAssigned"
  }
    lifecycle {
    ignore_changes = [
      # यह लाइन जोड़ो ताकि बार-बार modify ना दिखाए
      default_node_pool[0].upgrade_settings,
      default_node_pool[0].tags,
      tags
    ]
  }
}
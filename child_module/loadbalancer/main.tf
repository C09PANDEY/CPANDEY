resource "azurerm_lb" "loadbalancer" {
  for_each = var.load_balancers

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration
    content {
      name                 = frontend_ip_configuration.value.name
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
    } 
  }
}

# Backend address pool
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each = var.load_balancers

  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = each.value.backend_pool_name
}

# Health Probe
resource "azurerm_lb_probe" "probe" {
  for_each = var.load_balancers

  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = each.value.probe_name
  port            = each.value.probe_port
  protocol        = each.value.probe_protocol
}

# Load Balancer Rule
resource "azurerm_lb_rule" "rule" {
  for_each = var.load_balancers

  loadbalancer_id                = azurerm_lb.loadbalancer[each.key].id
  name                           = each.value.rule_name
  protocol                       = each.value.rule_protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}


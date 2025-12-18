output "load_balancer_ids" {
  description = "IDs of all load balancers"
  value = { for k, v in azurerm_lb.loadbalancer : k => v.id }
}

output "frontend_ip_configs" {
  description = "Frontend IP configs of each load balancer"
  value = { for k, v in azurerm_lb.loadbalancer : k => v.frontend_ip_configuration }
}

output "backend_pool_ids" {
  description = "Backend pool IDs for each load balancer"
  value = { for k, v in azurerm_lb_backend_address_pool.backend_pool : k => v.id }
}

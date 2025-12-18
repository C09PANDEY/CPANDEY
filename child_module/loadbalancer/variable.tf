variable "load_balancers" {
  description = "Map of load balancer configurations"
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    sku                   = optional(string)
    public_ip_id          = optional(string)
    # subnet_id             = optional(string)
    private_ip_address    = optional(string)
    private_ip_allocation = optional(string, "Dynamic")

    backend_pool_name     = optional(string)
    probe_name            = optional(string)
    probe_port            = optional(number)
    probe_protocol        = optional(string, "Tcp")

    rule_name             = optional(string)
    rule_protocol         = optional(string, "Tcp")
    frontend_port         = optional(number)
    backend_port          = optional(number)
    frontend_ip_configuration_name = optional (string)
    # subnet_name = string
    # virtual_network_name = string
    pip_name = string

     frontend_ip_configuration = optional (map(object({
      name = string
    }))) 
  }))
}

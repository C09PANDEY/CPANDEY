variable "rg" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "stg" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_replication_type = string
    account_tier             = string
    network_rules = list(object({
      default_action = string
      ip_rules       = list(string)
      bypass         = list(string)
    }))
  }))
}

variable "asc" {
  type = map(object({
    name                  = string
    storage_account_id    = optional(string)
    container_access_type = string
    stg_name              = string
    resource_group_name   = string
  }))
}

variable "vnet" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    subnet = map(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}

variable "pip" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
  }))
}

variable "kv" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
  }))
}

variable "secret" {
  type = map(object({
    name                = string
    value               = string
    kv_name             = string
    resource_group_name = string
  }))
}

variable "dbserver" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    minimum_tls_version          = string
    version                      = string
    kv_name                      = string
    administrator_login          = string
    administrator_login_password = string
  }))
}

variable "db" {
  type = map(object({
    name                = string
    resource_group_name = string
    collation           = string
    license_type        = string
    max_size_gb         = number
    sku_name            = string
    enclave_type        = string
    server_name         = string
  }))
}

variable "aks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    tags                = optional(list(string))
    default_node_pool = list(object({
      name       = string
      node_count = number
      vm_size    = string
    }))
  }))
}

variable "acr" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    admin_enabled       = bool
  }))
}

# variable "bastion" {
#   type = map(object({
#     name = string
#     location = string
#     resource_group_name = string
#     subnet_name = string
#     pip_name = string
#     virtual_network_name = string
#   }))
# }

variable "vm" {
    type = map(object({
      nsg_name = string
      resource_group_name = string
      location = string
      nic_name = string
      ip_configuration = list(object({
        name = string   
      })) 
      vm_name = string
      disable_password_authentication = bool
      size = string
      os_disk = list(object({
        caching = string 
        storage_account_type = string
      }))
      source_image_reference = list(object({
        publisher = string
        offer = string
        sku = string
        version = string
      }))
      custom_data = optional (string)
      subnet_name = string
      virtual_network_name = string
      pip_name = string
      kv_name = string
      administrator_login = string
      administrator_login_password = string
    }))
}


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

    tags                  = optional(map(string))
  }))
}

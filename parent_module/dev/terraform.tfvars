rg = {
  rg1 = {
    name       = "day2-dev-rg"
    location   = "west us 2"
    managed_by = "day2-devteam"
    tags = {
      env = "dev-team"
    }
  }
  rg2 = {
    name       = "day2-dev-rg2"
    location   = "central india"
    managed_by = "day2-devteam"
    tags = {
      env = "dev"
    }
  }
}

stg = {
  stg1 = {
    name                     = "finalwar3211"
    resource_group_name      = "day2-dev-rg"
    location                 = "west us 2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    network_rules = [{
      bypass         = ["AzureServices", "Logging"]
      default_action = "Deny"
      ip_rules       = ["100.0.0.1"]
    }]
  }
}

asc = {
  asc1 = {
    name                  = "lallilal"
    container_access_type = "private"
    stg_name              = "finalwar3211"
    resource_group_name   = "day2-dev-rg"
  }
}

vnet = {
  vnet1 = {
    name                = "day2-vnet"
    resource_group_name = "day2-dev-rg"
    location            = "west us 2"
    address_space       = ["10.0.0.0/16"]
    subnet = {
      subnet1 = {
        name             = "frontend_subnet"
        address_prefixes = ["10.0.1.0/27"]
      }
      subnet2 = {
        name             = "backend_subnet"
        address_prefixes = ["10.0.2.0/27"]
      }
      subnet3 = {
        name             = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/27"]
      }
    }
  }
  vnet2 = {
    name                = "day2-vnet2"
    resource_group_name = "day2-dev-rg2"
    location            = "central india"
    address_space       = ["10.0.0.0/16"]
    subnet = {
      subnet1 = {
        name             = "frontend_subnet"
        address_prefixes = ["10.0.1.0/27"]
      }
      subnet2 = {
        name             = "backend_subnet"
        address_prefixes = ["10.0.2.0/27"]
      }
      subnet3 = {
        name             = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/27"]
      }
    }
  }
}

pip = {
  pip1 = {
    name                = "day2pip"
    location            = "west us 2"
    resource_group_name = "day2-dev-rg"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "day2pip2"
    location            = "west us 2"
    resource_group_name = "day2-dev-rg"
    allocation_method   = "Static"
  }
  pip3 = {
    name                = "day2pip3"
    location            = "central india"
    resource_group_name = "day2-dev-rg2"
    allocation_method   = "Static"
  }
  pip4 = {
    name                = "day2pip3"
    location            = "west us 2"
    resource_group_name = "day2-dev-rg"
    allocation_method   = "Static"
  }
}

kv = {
  kv1 = {
    name                        = "jaihodullubabaki"
    location                    = "west us 2"
    resource_group_name         = "day2-dev-rg"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
  }
}

secret = {
  secret1 = {
    name                = "vm-username"
    value               = "adminuser"
    kv_name             = "jaihodullubabaki"
    resource_group_name = "day2-dev-rg"
  }
  secret2 = {
    name                = "vm-password"
    value               = "Ajay@2971994"
    kv_name             = "jaihodullubabaki"
    resource_group_name = "day2-dev-rg"
  }
}

dbserver = {
  dbserver1 = {
    name                         = "day2dbserver-20251111"
    resource_group_name          = "day2-dev-rg"
    location                     = "west us 2"
    minimum_tls_version          = "1.2"
    version                      = "12.0"
    kv_name                      = "jaihodullubabaki"
    administrator_login          = "vm-username"
    administrator_login_password = "vm-password"
  }
}

db = {
  db1 = {
    name                = "mydb1"
    resource_group_name = "day2-dev-rg"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    sku_name            = "S0"
    enclave_type        = "VBS"
    server_name         = "day2dbserver-20251111"
  }
}

aks = {
  aks1 = {
    name                = "day2aks"
    location            = "central india"
    resource_group_name = "day2-dev-rg2"
    dns_prefix          = "aadidns"
    default_node_pool = [{
      name       = "day2pool"
      node_count = 1
      vm_size    = "Standard_DC2s_v3"
    }]
  }
}

acr = {
  acr1 = {
    name                = "day2acrbhai"
    location            = "central india"
    resource_group_name = "day2-dev-rg2"
    sku                 = "Premium"
    admin_enabled       = false
  }
}

# bastion = {
#   bastion1 = {
#     name                 = "AzureBastionSubnet"
#     location             = "west us 2"
#     resource_group_name  = "day2-dev-rg"
#     pip_name             = "day2pip2"
#     subnet_name          = "AzureBastionSubnet"
#     virtual_network_name = "day2-vnet"
#   }
#   bastion2 = {
#     name                 = "AzureBastionSubnet1"
#     location             = "central india"
#     resource_group_name  = "day2-dev-rg2"
#     pip_name             = "day2pip3"
#     subnet_name          = "AzureBastionSubnet"
#     virtual_network_name = "day2-vnet2"
#   }
# }

vm = {
  vm1 = {
    nsg_name            = "day2_nsg1"
    resource_group_name = "day2-dev-rg"
    location            = "west us 2"
    nic_name            = "day2_nic1"
    ip_configuration = [{
      name = "day2vm"
    }]
    vm_name                         = "frontendvmday2"
    disable_password_authentication = false
    size                            = "Standard_D2as_v5"
    os_disk = [{
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }]
    source_image_reference = [{
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }]
    subnet_name                  = "frontend_subnet"
    pip_name                     = "day2pip"
    kv_name                      = "jaihodullubabaki"
    administrator_login          = "vm-username"
    administrator_login_password = "vm-password"
    virtual_network_name         = "day2-vnet"
custom_data = <<-EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
  
  }

    vm2 = {
    nsg_name            = "day2_nsg2"
    resource_group_name = "day2-dev-rg"
    location            = "west us 2"
    nic_name            = "day2_nic2"
    ip_configuration = [{
      name = "day2vm2"
    }]
    vm_name                         = "backendendvmday2"
    disable_password_authentication = false
    size                            = "Standard_D2as_v5"
    os_disk = [{
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }]
    source_image_reference = [{
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }]
    subnet_name                  = "backend_subnet"
    pip_name                     = "day2pip2"
    kv_name                      = "jaihodullubabaki"
    administrator_login          = "vm-username"
    administrator_login_password = "vm-password"
    virtual_network_name         = "day2-vnet"
  }
}


load_balancers = {
  "load_balancers1" = {
    name                           = "day2loadbalancer"
    resource_group_name            = "day2-dev-rg"
    location                       = "west us 2"
    sku                            = "Standard"
    backend_pool_name              = "daywbackendpool"
    probe_name                     = "dayprobe"
    probe_port                     = 80
    probe_protocol                 = "Tcp"
    rule_name                      = "day2rule"
    rule_protocol                  = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "day2frontconf"
    pip_name = "day2pip3"
    frontend_ip_configuration = {
      "frontend1" = {
        name = "day2frontconf"
      }
    }
  }
}

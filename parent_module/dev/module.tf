module "resource_groups" {
  source = "../../child_module/resource_group"
  rg = var.rg
}
output "all_resource_groups" {
  value = { for k, v in module.resource_groups : k => v }
}

module "storage_account" {
  source = "../../child_module/storage_account"
  depends_on = [ module.resource_groups ]

  stg = var.stg
}
output "storage_account" {
  value = module.storage_account.my_account["stg1"]
}

module "storage_container" {
  source = "../../child_module/storage_account_container_reg"
  depends_on = [ module.storage_account ]
  asc = var.asc
}

module "virtual_netowrk" {
  source = "../../child_module/virtual_network"
  depends_on = [ module.resource_groups ]
  vnet = var.vnet
}

module "public_ip" {
  source = "../../child_module/public_ip"
  depends_on = [ module.resource_groups ]
  pip = var.pip
}

module "key_vault" {
  source = "../../child_module/key_vault"
  depends_on = [ module.resource_groups ]
  kv = var.kv
}

module "key_vault_secret" {
  source = "../../child_module/key_vault_server"
  depends_on = [ module.key_vault ]
  secret = var.secret
}

module "dbserver" {
  source = "../../child_module/sql_server"
  depends_on = [ module.key_vault, module.key_vault_secret ]
  dbserver = var.dbserver
}

module "database" {
  source = "../../child_module/sql_database"
  depends_on = [ module.dbserver ]
  db = var.db
}

module "azurerm_kubernetes_cluster" {
  source = "../../child_module/kubernetes_cluster"
  depends_on = [ module.resource_groups, module.virtual_netowrk, module.public_ip]
  aks = var.aks
}

module "azurerm_container_registry" {
  source = "../../child_module/kubenetes_container_registry"
  depends_on = [ module.resource_groups, module.public_ip, module.virtual_netowrk ]
  acr = var.acr
}

# module "bastion" {
#   source = "../../child_module/bastion"
#   depends_on = [ module.public_ip, module.virtual_netowrk, module.storage_account ]
#   bastion = var.bastion
# }

module "azurerm_linux_virtual_machine" {
  source = "../../child_module/virtual_machine"
  depends_on = [ module.resource_groups, module.key_vault, module.key_vault_secret, module.public_ip, module.storage_account, module.virtual_netowrk]
  vm = var.vm
}

module "load_balancer" {
  source = "../../child_module/loadbalancer"
  depends_on = [ module.azurerm_linux_virtual_machine ]
  load_balancers = var.load_balancers
}
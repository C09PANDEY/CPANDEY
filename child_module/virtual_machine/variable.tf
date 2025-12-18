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

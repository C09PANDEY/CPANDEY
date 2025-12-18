variable "dbserver" {
  type = map(object({
    name = string 
    resource_group_name = string
    location = string
    minimum_tls_version = string
    version = string
    kv_name = string
    administrator_login = string
    administrator_login_password = string
  }))
}
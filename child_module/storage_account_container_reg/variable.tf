variable "asc" {
  type = map(object({
    name = string
    storage_account_id = optional (string)
    container_access_type = string
    stg_name = string
    resource_group_name = string 
  }))
}
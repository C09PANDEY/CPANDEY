variable "secret" {
  type = map(object({
    name = string
    value = string 
    kv_name = string
    resource_group_name = string
  }))
}
variable "stg" {
  type = map(object({
    name = string
    resource_group_name = string
    location = string
    account_replication_type = string
    account_tier = string
    network_rules = list(object({
      default_action = string
      ip_rules = list(string)
      bypass = list(string)
    }))
  }))
}
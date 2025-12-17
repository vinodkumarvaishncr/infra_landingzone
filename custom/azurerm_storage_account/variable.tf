variable "storage_account_list" {
  description = "Map of storage accounts to create with optional advanced configuration"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    account_kind             = optional(string)
    cross_tenant_replication_enabled  = optional(bool)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    tags                              = map(string)

    # Optional blocks
    custom_domain = optional(list(object({
      name          = string
      use_subdomain = optional(bool)
    })))

    customer_managed_key = optional(list(object({
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
      user_assigned_identity_id = string
    })))

    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))

    delete_retention_policy = optional(list(object({
      days    = optional(number)
       
    })))

    restore_policy = optional(list(object({
      days = number
    })))

    versioning_enabled            = optional(bool)
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)

    container_delete_retention_policy = optional(list(object({
      days    = optional(number)
       
    })))
  }))
}
resource "azurerm_storage_account" "storageacc" {
  for_each = var.storage_account_list

  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  account_kind             = try(each.value.account_kind, "StorageV2")
  cross_tenant_replication_enabled  = try(each.value.cross_tenant_replication_enabled, false)
  https_traffic_only_enabled        = try(each.value.https_traffic_only_enabled, true)
  min_tls_version                   = try(each.value.min_tls_version, "TLS1_2")
  allow_nested_items_to_be_public   = try(each.value.allow_nested_items_to_be_public, false)
  tags                              = each.value.tags

  # ---------------------------
  # Optional Blocks
  # ---------------------------

  # Custom Domain
  dynamic "custom_domain" {
    for_each = coalesce(each.value.custom_domain, []) 
    content {
      name           = custom_domain.value.name
      use_subdomain  = try(custom_domain.value.use_subdomain, false)
    }
  }

  # Customer Managed Key
  dynamic "customer_managed_key" {
    for_each = coalesce(each.value.customer_managed_key, [])
    content {
      key_vault_key_id         = try(customer_managed_key.value.key_vault_key_id, null)
      managed_hsm_key_id       = try(customer_managed_key.value.managed_hsm_key_id, null)
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  # Blob properties configuration
  blob_properties {
    # CORS
    dynamic "cors_rule" {
      for_each = coalesce(each.value.cors_rule, [])
      content {
        allowed_headers    = cors_rule.value.allowed_headers
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_origins    = cors_rule.value.allowed_origins
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }

    # Delete retention policy
    dynamic "delete_retention_policy" {
      for_each = coalesce(each.value.delete_retention_policy, [])
      content {
        days    = try(delete_retention_policy.value.days, 7)
        
      }
    }

    # Restore policy
    dynamic "restore_policy" {
      for_each = coalesce(each.value.restore_policy, [])
      content {
        days = restore_policy.value.days
      }
    }

    # Other optional blob settings
    versioning_enabled             = try(each.value.versioning_enabled, false)
    change_feed_enabled            = try(each.value.change_feed_enabled, false)
    change_feed_retention_in_days  = try(each.value.change_feed_retention_in_days, null)
    default_service_version        = try(each.value.default_service_version, null)
    last_access_time_enabled       = try(each.value.last_access_time_enabled, false)

    # Container delete retention policy
    dynamic "container_delete_retention_policy" {
      for_each = coalesce(each.value.container_delete_retention_policy, [])
      content {
        days    = try(container_delete_retention_policy.value.days, 7)
         
      }
    }
  }
}
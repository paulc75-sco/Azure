locals {
  common_tags = {
    "Environment" = terraform.workspace
    "LastUpdated" = timestamp()
    "Created By"  = data.azuread_user.current_user.user_principal_name
  }

  # Merge common tags with provided tags
  all_tags = merge(var.tags, local.common_tags)
}

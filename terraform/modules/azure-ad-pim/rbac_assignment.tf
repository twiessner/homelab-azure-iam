
data "azurerm_management_group" "scope" {
  for_each     = var.azure_rbac_assignments
  display_name = each.value.management_group_name
}

data "azurerm_role_definition" "role" {
  for_each = var.azure_rbac_assignments
  name     = each.value.role_name
}

resource "random_uuid" "pim" {
  for_each = var.azure_rbac_assignments

  keepers = {
    role_name = each.value.role_name
    scope     = each.value.management_group_name
  }
}

resource "azapi_resource" "pim" {
  for_each = var.azure_rbac_assignments

  type      = "Microsoft.Authorization/roleEligibilityScheduleRequests@2022-04-01-preview"
  name      = random_uuid.pim[each.key].result
  parent_id = data.azurerm_management_group.scope[each.key].id

  body = jsonencode({
    properties = {
      principalId      = var.group_id
      requestType      = "AdminRenew"
      roleDefinitionId = data.azurerm_role_definition.role[each.key].id
      scheduleInfo = {
        expiration = {
          duration    = "P365D"
          type        = "AfterDuration"
        }
      }
    }
  })
}
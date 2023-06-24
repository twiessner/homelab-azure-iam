
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
    role_id   = data.azurerm_role_definition.role[each.key].id
    duration  = each.value.expiration_days
  }
}

resource "azapi_resource" "pim" {
  for_each = var.azure_rbac_assignments

  type      = "Microsoft.Authorization/roleEligibilityScheduleRequests@2020-10-01"
  name      = random_uuid.pim[each.key].result
  parent_id = data.azurerm_management_group.scope[each.key].id

  body = jsonencode({
    properties = {
      principalId      = var.group_id
      requestType      = "AdminUpdate"
      roleDefinitionId = data.azurerm_role_definition.role[each.key].id
      scheduleInfo = {
        expiration = {
          duration = "P${each.value.expiration_days}D"
          type     = "AfterDuration"
        }
      }
    }
  })
}
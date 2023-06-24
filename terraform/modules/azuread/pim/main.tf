
/**
data "http" "pim" {
  for_each = var.azure_ad_role_names

  url = "https://graph.microsoft.com/beta/privilegedAccess/aadroles/roleAssignmentRequests"
  method = "POST"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }

  request_body = jsonencode({
    "roleDefinitionId": "62e90394-69f5-4237-9190-012177145e10",
    "resourceId": var.tenant_id,
    "subjectId": var.group_id,
    "assignmentState": "Eligible",
    "type": "AdminAdd",
    "reason": "Implementing company requirements.",
    "schedule": {
      "startDateTime": {DateTime},
      "endDateTime": {DateTime},
      "type": "Once"
  })
}

resource "random_uuid" "example" {
  lifecycle {
    precondition {
      condition     = contains([201, 204], data.http.example.status_code)
      error_message = "Status code invalid"
    }
  }
}
**/
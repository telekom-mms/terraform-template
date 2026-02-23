# terraform-azuread-identity

A Terraform module that manages azuread user, azuread group, azuread application, azuread service principal, azuread application password, azuread service principal password resources.

## Usage

```hcl
module "identity" {
  source  = "registry.terraform.io/telekom-mms/identity/azuread"
  version = "1.0.0"

  users = {
    user1 = {
      display_name        = "User One"
      user_principal_name = "user1@example.com"
      mail_nickname       = "user1"
      password            = "Password123!"
    }
  }

  groups = {
    group1 = {
      display_name     = "Group One"
      security_enabled = true
    }
  }

  applications = {
    app1 = {
      display_name = "Application One"
    }
  }

  service_principals = {
    sp1 = {
      application_id = "00000000-0000-0000-0000-000000000000"
    }
  }
}
```

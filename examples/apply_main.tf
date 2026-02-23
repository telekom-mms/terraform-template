resource "azuread_application" "dependency" {
  display_name = "rg-mms-github-dependency-app"
}

module "identity" {
  source = "registry.terraform.io/telekom-mms/identity/azuread"

  user = {
    "mms-github" = {
      mail_nickname       = "github"
      user_principal_name = "user-example@mms-github.com"
      password            = "SuperSecretPassword123!"
    }
  }

  group = {
    "mms-github" = {
      security_enabled = true
    }
  }

  group_member = {
    "mms-github" = {
      group_object_id  = module.identity.group["mms-github"].object_id
      member_object_id = module.identity.user["mms-github"].object_id
    }
  }

  application = {
    "app-mms-github" = {}
  }

  application_password = {
    "app-pw-mms-github" = {
      application_object_id = module.identity.application["app-mms-github"].object_id
    }
  }

  service_principal = {
    "sp-mms-github" = {
      application_id = module.identity.application["app-mms-github"].application_id
    }
  }

  service_principal_password = {
    "sp-pw-mms-github" = {
      service_principal_id = module.identity.service_principal["sp-mms-github"].object_id
    }
  }
}

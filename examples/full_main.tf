module "identity" {
  source = "registry.terraform.io/telekom-mms/identity/azuread"

  user = {
    "mms-github" = {
      account_enabled             = true
      city                        = "Berlin"
      company_name                = "Telekom MMS"
      country                     = "Germany"
      department                  = "DevOps"
      disable_password_expiration = false
      disable_strong_password     = false
      display_name                = "MMS Github User"
      given_name                  = "MMS"
      job_title                   = "DevOps Engineer"
      mail_nickname               = "github"
      mobile_phone                = "+49 123 456789"
      office_location             = "Berlin"
      other_mails                 = ["mms-github-secondary@example.com"]
      password                    = "SuperSecretPassword123!"
      postal_code                 = "10115"
      preferred_language          = "en-US"
      show_in_address_list        = true
      state                       = "Berlin"
      surname                     = "Github"
      usage_location              = "DE"
      user_principal_name         = "user-example@mms-github.com"
      force_password_change       = false
    }
  }

  group = {
    "mms-github" = {
      assignable_to_role         = false
      auto_subscribe_new_members = true
      description                = "Full example group with security enabled"
      display_name               = "MMS Github Group"
      external_senders_allowed   = false
      hide_from_address_lists    = false
      hide_from_outlook_clients  = false
      mail_enabled               = false
      mail_nickname              = "mms-github"
      prevent_duplicate_names    = true
      security_enabled           = true
      theme                      = "Blue"
      visibility                 = "Private"
    }
  }

  group_member = {
    "mms-github" = {
      group_object_id  = module.identity.group["mms-github"].object_id
      member_object_id = module.identity.user["mms-github"].object_id
    }
  }

  application = {
    "app-mms-github" = {
      device_only_auth_enabled       = false
      display_name                   = "App MMS Github"
      fallback_public_client_enabled = false
      group_membership_claims        = ["SecurityGroup"]
      identifier_uris                = ["api://app-mms-github"]
      marketing_url                  = "https://example.com/marketing"
      oauth2_post_response_required  = true
      prevent_duplicate_names        = true
      privacy_statement_url          = "https://example.com/privacy"
      sign_in_audience               = "AzureADMyOrg"
      support_url                    = "https://example.com/support"
      template_id                    = null
      terms_of_service_url           = "https://example.com/terms"
      
      web = {
        homepage_url  = "https://example.com"
        logout_url    = "https://example.com/logout"
        redirect_uris = ["https://example.com/callback"]
      }

      required_resource_access = {
        "microsoft-graph" = {
          resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
          resource_access = {
            "User.Read" = {
              id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
              type = "Scope"
            }
          }
        }
      }

      tags = ["mms", "github", "full-configuration"]
    }
  }

  application_password = {
    "app-pw-mms-github" = {
      application_object_id = module.identity.application["app-mms-github"].object_id
      display_name          = "Full App Password"
      end_date_relative     = "8760h" # 1 year
      rotate_when_changed   = { rotation = "yearly" }
    }
  }

  service_principal = {
    "sp-mms-github" = {
      account_enabled               = true
      alternative_names             = ["alt-sp-mms-github"]
      app_role_assignment_required  = false
      application_id                = module.identity.application["app-mms-github"].application_id
      description                   = "Service Principal for MMS Github App"
      login_url                     = "https://example.com/login"
      notes                         = "This is a full example service principal."
      notification_email_addresses  = ["admin@example.com"]
      preferred_single_sign_on_mode = "saml"
      use_existing                  = false
      
      feature_tags = {
        custom_single_sign_on = true
        enterprise            = true
        gallery               = true
        hide                  = false
      }

      saml_single_sign_on = {
        relay_state = "https://example.com/saml/relay"
      }

      tags = ["service-principal", "mms", "github"]
    }
  }

  service_principal_password = {
    "sp-pw-mms-github" = {
      service_principal_id = module.identity.service_principal["sp-mms-github"].object_id
      display_name         = "Full SP Password"
      end_date_relative    = "8760h" # 1 year
      rotate_when_changed  = { rotation = "yearly" }
    }
  }
}

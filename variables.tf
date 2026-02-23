variable "user" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "group" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "group_member" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "application" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "application_password" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "service_principal" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "service_principal_password" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

locals {
  default = {
    // resource definition
    user = {
      account_enabled             = null
      age_group                   = null
      business_phones             = null
      city                        = null
      company_name                = null
      consent_provided_for_minor  = null
      cost_center                 = null
      country                     = null
      department                  = null
      disable_password_expiration = false // defined default
      disable_strong_password     = false // defined default
      display_name                = ""
      division                    = null
      employee_id                 = null
      employee_type               = null
      fax_number                  = null
      force_password_change       = true // defined default
      given_name                  = null
      job_title                   = null
      mail                        = null
      mail_nickname               = null
      manager_id                  = null
      mobile_phone                = null
      office_location             = null
      onpremises_immutable_id     = null
      other_mails                 = null
      password                    = "change_IT#9" // defined default
      postal_code                 = null
      preferred_language          = null
      show_in_address_list        = false // defined default
      state                       = null
      street_address              = null
      surname                     = null
      usage_location              = null
    }
    group = {
      assignable_to_role         = null
      auto_subscribe_new_members = null
      behaviors                  = null
      description                = null
      display_name               = ""
      external_senders_allowed   = null
      hide_from_address_lists    = null
      hide_from_outlook_clients  = null
      mail_enabled               = false // defined default
      mail_nickname              = null
      members                    = []
      owners                     = null
      prevent_duplicate_names    = true // defined default
      provisioning_options       = null
      security_enabled           = true // defined default
      theme                      = null
      types                      = null
      visibility                 = null
      dynamic_membership = {
        enabled = true
        rule    = ""
      }
    }
    group_member = {}
    application = {
      device_only_auth_enabled       = null
      display_name                   = ""
      fallback_public_client_enabled = null
      group_membership_claims        = null
      identifier_uris                = []
      logo_image                     = null
      marketing_url                  = null
      oauth2_post_response_required  = null
      owners                         = null
      prevent_duplicate_names        = true // defined default
      privacy_statement_url          = null
      sign_in_audience               = null
      support_url                    = null
      template_id                    = null
      terms_of_service_url           = null
      api                            = {}
      app_role                       = {}
      feature_tags                   = {}
      optional_claims                = {}
      public_client                  = {}
      required_resource_access       = {}
      single_page_application        = {}
      web                            = {
        homepage_url  = null
        logout_url    = null
        redirect_uris = []
      }
      tags                           = null
    }
    application_password = {
      display_name        = ""
      end_date            = null
      end_date_relative   = null
      rotate_when_changed = null
      start_date          = null
    }
    service_principal = {
      account_enabled               = null
      alternative_names             = null
      app_role_assignment_required  = null
      description                   = ""
      login_url                     = null
      notes                         = null
      notification_email_addresses  = null
      owners                        = null
      preferred_single_sign_on_mode = null
      use_existing                  = null
      feature_tags                  = null
      saml_single_sign_on = {
        relay_state = null
      }
      tags = null
    }
    service_principal_password = {
      display_name        = ""
      end_date            = null
      end_date_relative   = null
      rotate_when_changed = null
      start_date          = null
    }

  }

  // compare and merge custom and default values
  group_values = {
    for group in keys(var.group) :
    group => merge(local.default.group, var.group[group])
  }
  application_values = {
    for application in keys(var.application) :
    application => merge(local.default.application, var.application[application])
  }

  // merge all custom and default values
  user = {
    for user in keys(var.user) :
    user => merge(local.default.user, var.user[user])
  }
  group = {
    for group in keys(var.group) :
    group => merge(
      local.group_values[group],
      {
        for config in ["dynamic_membership"] :
        config => merge(local.default.group[config], local.group_values[group][config] == null ? {} : local.group_values[group][config])
      }
    )
  }
  group_member = {
    for group_member in keys(var.group_member) :
    group_member => merge(local.default.group_member, var.group_member[group_member])
  }
  application = {
    for application in keys(var.application) :
    application => merge(
      local.application_values[application],
      {
        for config in ["required_resource_access"] :
        config => {
          for key in keys(local.application_values[application][config]) :
          key => merge(local.default.application[config], local.application_values[application][config][key])
        }
      },
    )
  }
  application_password = {
    for application_password in keys(var.application_password) :
    application_password => merge(local.default.application_password, var.application_password[application_password])
  }
  service_principal = {
    for service_principal in keys(var.service_principal) :
    service_principal => merge(local.default.service_principal, var.service_principal[service_principal])
  }
  service_principal_password = {
    for service_principal_password in keys(var.service_principal_password) :
    service_principal_password => merge(local.default.service_principal_password, var.service_principal_password[service_principal_password])
  }
}
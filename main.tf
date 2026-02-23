/**
* # identity
*
* This module manages the hashicorp/azuread resources.
* For more information see https://registry.terraform.io/providers/hashicorp/azuread/latest/docs
*
*/

resource "azuread_user" "user" {
  for_each = var.user

  account_enabled             = local.user[each.key].account_enabled
  age_group                   = local.user[each.key].age_group
  business_phones             = local.user[each.key].business_phones
  city                        = local.user[each.key].city
  company_name                = local.user[each.key].company_name
  consent_provided_for_minor  = local.user[each.key].consent_provided_for_minor
  cost_center                 = local.user[each.key].cost_center
  country                     = local.user[each.key].country
  department                  = local.user[each.key].department
  disable_password_expiration = local.user[each.key].disable_password_expiration
  disable_strong_password     = local.user[each.key].disable_strong_password
  display_name                = local.user[each.key].display_name == "" ? each.key : local.user[each.key].display_name
  division                    = local.user[each.key].division
  employee_id                 = local.user[each.key].employee_id
  employee_type               = local.user[each.key].employee_type
  fax_number                  = local.user[each.key].fax_number
  force_password_change       = local.user[each.key].force_password_change
  given_name                  = local.user[each.key].given_name
  job_title                   = local.user[each.key].job_title
  mail                        = local.user[each.key].mail
  mail_nickname               = local.user[each.key].mail_nickname
  manager_id                  = local.user[each.key].manager_id
  mobile_phone                = local.user[each.key].mobile_phone
  office_location             = local.user[each.key].office_location
  onpremises_immutable_id     = local.user[each.key].onpremises_immutable_id
  other_mails                 = local.user[each.key].other_mails
  password                    = local.user[each.key].password
  postal_code                 = local.user[each.key].postal_code
  preferred_language          = local.user[each.key].preferred_language
  show_in_address_list        = local.user[each.key].show_in_address_list
  state                       = local.user[each.key].state
  street_address              = local.user[each.key].street_address
  surname                     = local.user[each.key].surname
  usage_location              = local.user[each.key].usage_location
  user_principal_name         = replace(replace(replace(local.user[each.key].user_principal_name, "ü", "ue"), "ö", "oe"), "ä", "ae")
}

resource "azuread_group" "group" {
  for_each = var.group

  assignable_to_role         = local.group[each.key].assignable_to_role
  auto_subscribe_new_members = local.group[each.key].auto_subscribe_new_members
  behaviors                  = local.group[each.key].behaviors
  description                = local.group[each.key].description
  display_name               = local.group[each.key].display_name == "" ? each.key : local.group[each.key].display_name
  external_senders_allowed   = local.group[each.key].external_senders_allowed
  hide_from_address_lists    = local.group[each.key].hide_from_address_lists
  hide_from_outlook_clients  = local.group[each.key].hide_from_outlook_clients
  mail_enabled               = local.group[each.key].mail_enabled
  mail_nickname              = local.group[each.key].mail_nickname
  members                    = local.group[each.key].members
  owners                     = local.group[each.key].owners
  prevent_duplicate_names    = local.group[each.key].prevent_duplicate_names
  provisioning_options       = local.group[each.key].provisioning_options
  security_enabled           = local.group[each.key].security_enabled
  theme                      = local.group[each.key].theme
  types                      = local.group[each.key].types
  visibility                 = local.group[each.key].visibility

  dynamic "dynamic_membership" {
    for_each = local.group[each.key].dynamic_membership.rule != "" ? [1] : []

    content {
      enabled = local.group[each.key].dynamic_membership.enabled
      rule    = local.group[each.key].dynamic_membership.rule
    }
  }
}

resource "azuread_group_member" "group_member" {
  for_each = var.group_member

  group_object_id  = local.group_member[each.key].group_object_id
  member_object_id = local.group_member[each.key].member_object_id
}

resource "azuread_application" "application" {
  for_each = var.application

  device_only_auth_enabled       = local.application[each.key].device_only_auth_enabled
  display_name                   = local.application[each.key].display_name == "" ? each.key : local.application[each.key].display_name
  fallback_public_client_enabled = local.application[each.key].fallback_public_client_enabled
  group_membership_claims        = local.application[each.key].group_membership_claims
  identifier_uris                = local.application[each.key].identifier_uris
  logo_image                     = local.application[each.key].logo_image
  marketing_url                  = local.application[each.key].marketing_url
  oauth2_post_response_required  = local.application[each.key].oauth2_post_response_required
  owners                         = local.application[each.key].owners
  prevent_duplicate_names        = local.application[each.key].prevent_duplicate_names
  privacy_statement_url          = local.application[each.key].privacy_statement_url
  sign_in_audience               = local.application[each.key].sign_in_audience
  support_url                    = local.application[each.key].support_url
  template_id                    = local.application[each.key].template_id
  terms_of_service_url           = local.application[each.key].terms_of_service_url

  dynamic "web" {
    for_each = local.application[each.key].web != null ? ["true"] : []
    content {
      redirect_uris = local.application[each.key].web.redirect_uris
    }
  }

  dynamic "required_resource_access" {
    for_each = local.application[each.key].required_resource_access

    content {
      resource_app_id = local.application[each.key].required_resource_access[required_resource_access.key].resource_app_id

      dynamic "resource_access" {
        for_each = local.application[each.key].required_resource_access[required_resource_access.key].resource_access

        content {
          id   = local.application[each.key].required_resource_access[required_resource_access.key].resource_access[resource_access.key].id
          type = local.application[each.key].required_resource_access[required_resource_access.key].resource_access[resource_access.key].type
        }
      }
    }
  }

  tags = local.application[each.key].tags
}

resource "azuread_application_password" "application_password" {
  for_each = var.application_password

  application_object_id = local.application_password[each.key].application_object_id
  display_name          = local.application_password[each.key].display_name == "" ? each.key : local.application_password[each.key].display_name
  end_date              = local.application_password[each.key].end_date
  end_date_relative     = local.application_password[each.key].end_date_relative
  rotate_when_changed   = local.application_password[each.key].rotate_when_changed
  start_date            = local.application_password[each.key].start_date
}

resource "azuread_service_principal" "service_principal" {
  for_each = var.service_principal

  account_enabled               = local.service_principal[each.key].account_enabled
  alternative_names             = local.service_principal[each.key].alternative_names
  app_role_assignment_required  = local.service_principal[each.key].app_role_assignment_required
  application_id                = local.service_principal[each.key].application_id
  description                   = local.service_principal[each.key].description
  login_url                     = local.service_principal[each.key].login_url
  notes                         = local.service_principal[each.key].notes
  notification_email_addresses  = local.service_principal[each.key].notification_email_addresses
  owners                        = local.service_principal[each.key].owners
  preferred_single_sign_on_mode = local.service_principal[each.key].preferred_single_sign_on_mode
  use_existing                  = local.service_principal[each.key].use_existing

  dynamic "feature_tags" {
    for_each = local.service_principal[each.key].feature_tags != null ? [1] : []

    content {
      custom_single_sign_on = local.service_principal[each.key].feature_tags.custom_single_sign_on
      enterprise            = local.service_principal[each.key].feature_tags.enterprise
      gallery               = local.service_principal[each.key].feature_tags.gallery
      hide                  = local.service_principal[each.key].feature_tags.hide
    }
  }

  dynamic "saml_single_sign_on" {
    for_each = local.service_principal[each.key].saml_single_sign_on.relay_state != null ? [1] : []

    content {
      relay_state = local.service_principal[each.key].saml_single_sign_on.relay_state
    }
  }

  tags = local.service_principal[each.key].tags
}

resource "azuread_service_principal_password" "service_principal_password" {
  for_each = var.service_principal_password

  display_name         = local.service_principal_password[each.key].display_name == "" ? each.key : local.service_principal_password[each.key].display_name
  end_date             = local.service_principal_password[each.key].end_date
  end_date_relative    = local.service_principal_password[each.key].end_date_relative
  rotate_when_changed  = local.service_principal_password[each.key].rotate_when_changed
  service_principal_id = local.service_principal_password[each.key].service_principal_id
  start_date           = local.service_principal_password[each.key].start_date
}
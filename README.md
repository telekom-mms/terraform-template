# Terraform Module

## Naming

The basic approach to our Terraform modules is as follows:

```bash
terraform-<provider-name>-<modul-name>
```

This results in the following scheme for our Azure modules, for example:

```bash
terraform-azurerm-container
terraform-azuread-application
terraform-azuredevops-project
```

## Structure

The name, structure and content of a module are based on the provider.

This means how a module is named and which resources are combined into a module depends on the provider implementation. This implementation should bring the following simplifications:

* When working with the module, you can also refer to the provider documentation.
* If the resource does not exist in the module, then it does not currently exist. -> An addition to the module is therefore necessary, this can be done by contributing or opening an enhancement issue.

| provider   | documentation                                                                                   | code base                                                                                                    |
| ---------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| azurerm    | [terraform registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)     | [github](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/internal/services)                |
| azuread    | [terraform registry](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs)     | [github](https://github.com/hashicorp/terraform-provider-azuread/tree/main/internal/services)                |
| azuredevops| [terraform registry](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs) | [github](https://github.com/microsoft/terraform-provider-azuredevops/tree/main/azuredevops/internal/service) |

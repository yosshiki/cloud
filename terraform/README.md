# terraform
https://www.terraform.io/  
- latest: https://developer.hashicorp.com/terraform/downloads  
- 1.5.7
- 1.4.0

## Usage
- create XXX.tf and terraform.tfvars file
  - provider.tf / variable.tf
- learn commands
  - init / import / plan / apply
- state management
  - create \<env>.tfbackend

## providers
|provider|URL|
| ---- | ---- |
|azurerm|[URL](https://github.com/yosshiki/cloud/tree/main/terraform#provider_azurerm)|
|azuread|[URL](https://github.com/yosshiki/cloud/tree/main/terraform#provider_azuread)|
|random|[URL](https://github.com/yosshiki/cloud/tree/main/terraform#provider_random)|


# provider_azurerm
https://github.com/hashicorp/terraform-provider-azurerm  
- latest: https://registry.terraform.io/providers/hashicorp/azurerm/latest  
- 3.72
- 3.58
- 3.50

## Usage
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs  
- default: user authentication
- service principal: `export ARM_XXX` and `terraform init`
  - `ARM_CLIENT_SECRET`
  - `ARM_CLIENT_ID`,`ARM_TENANT_ID`,`ARM_SUBSCRIPTION_ID` can be set by tfbackend file.
  - if using shell script, use `source` command

## modules
|module|URL|
| ---- | ---- |
| -- resource group -- | ---- |
|azurerm_resource_group||
|-- network --| ---- |
|azurerm_virtual_network||
|azurerm_subnet||
|azurerm_network_security_group||
|azurerm_subnet_network_security_group_association||
|azurerm_network_interface_security_group_association||
|azurerm_route_table||
|azurerm_subnet_route_table_association||
|azurerm_private_endpoint||
|-- dns --| ---- |
|azurerm_private_dns_resolver||
|azurerm_private_dns_resolver_outbound_endpoint||
|azurerm_private_dns_resolver_dns_forwarding_ruleset||
|azurerm_private_dns_resolver_forwarding_rule||
|azurerm_private_dns_zone||
|azurerm_private_dns_zone_virtual_nework_link||
|-- application --| ---- |
|azurerm_service_plan||
|azurerm_user_assigned_identity||
|azurerm_linux_web_app||
|azurerm_linux_web_app_slot||
|azurerm_application_insights||
|-- db --| ---- |
|azurerm_mysql_flexible_server||
|azurerm_mysql_flexible_server_configuration||
|azurerm_mysql_flexible_database||
|-- storage --| ---- |
|azurerm_storage_account||
|azurerm_storage_container||
|-- databricks --| ---- |
|azurerm_databricks_workspace||
|azurerm_databricks_access_connector||
|-- security --| ---- |
|azurerm_key_vault||
|azurerm_key_vault_secret||
|azurerm_log_analytics_workspace||
|azurerm_monitor_diagnostic_setting||
|azurerm_security_center_contact||
|-- RBAC --| ---- |
|azurerm_role_assignment||
|-- fucntion --| ---- |
|azurerm_service_plan||
|azurerm_windows_function_app||
|azurerm_function_app_function||
|azurerm_application_insights||
|-- logic apps --| ---- |
|azurerm_api_connection| |
|azurerm_logic_app_workflow| |
|azurerm_logic_app_trigger_http_request| |
|-- budget --| ---- |
|azurerm_consumption_budget_subscription||

# provider_azuread
https://registry.terraform.io/providers/hashicorp/azuread/latest/docs  
- 2.4.3
- 2.4.1  

|module|URL|
| ---- | ---- |
|azuread_application||
|azuread_service_principal||
|azuread_service_principal_password||

# provider_random
|module|URL|
| ---- | ---- |
| random_password | [URL](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |
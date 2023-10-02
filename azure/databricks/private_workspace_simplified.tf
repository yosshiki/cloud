# private_workspace_simplified.tf

## variable ##
variable "env" {
    type = string
    description = "(optional) describe your variable"
}

variable "service" {
    type = string
    description = "(optional) describe your variable"
}

variable "region" {
    type = string
    description = "(optional) describe your variable"
    default = "je"
}

variable "location" {
    type = string
    description = "(optional) describe your variable"
    default = "japaneast"
}

variable "rg" {
    type = string
    description = "resource group name"
}

variable "cidr" {
    type = string
    description = "(optional) describe your variable"
}

variable "tag" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        managedby = "terraform"
    }
}

variable "app_tag" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        "managedbyterraform",
    }
}


locals {
  prefix = "abd-pl"
  tags = {
    Environment = "Demo"
    Owner       = lookup(data.external.me.result, "name")
  }
}

## resource
### network
resource azurerm_virtual_network "main" {
    name                = "${local.prefix}-vnet"
    location            = var.location
    resource_group_name = var.rg
    address_space       = [var.cidr]
    tags                = var.tags
#    tags                = merge(var.tags, {"environment"=${var.env}})
}

## cidrsubnets(prefix, newbits...)

resource azurerm_subnet "private_endpoint" {
    name                                           = "${local.prefix}-privatelink"
    resource_group_name                            = var.rg
    virtual_network_name                           = azurerm_virtual_network.main.name
    address_prefixes                               = [cidrsubnet(var.cidr, 3, 2)]
    enforce_private_link_endpoint_network_policies = true
}

resource azurerm_subnet "adb_dp_private" {
    name                 = "${local.prefix}-private"
    resource_group_name  = var.rg
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = [cidrsubnet(var.cidr, 3, 1)]
  
    enforce_private_link_endpoint_network_policies = true
    enforce_private_link_service_network_policies  = true
  
    delegation {
      name = "databricks"
      service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    }
  
    service_endpoints = var.private_subnet_endpoints
}

resource azurerm_subnet "adb_dp_public" {
    name                 = "${local.prefix}-public"
    resource_group_name  = var.rg
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = [cidrsubnet(var.cidr, 3, 0)]
  
    delegation {
      name = "databricks"
      service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    }
}


resource azurerm_network_security_group "adb_dp" {
    name                = "${local.prefix}-adb-dp-nsg"
    location            = var.location
    resource_group_name = var.rg
    tags                = var.tags
#    tags                = merge(var.tags, {"environment"=${var.env}})
}

resource "azurerm_subnet_network_security_group_association" "adb_dp_public" {
  subnet_id                 = azurerm_subnet.adb_dp_public.id
  network_security_group_id = azurerm_network_security_group.adb_dp.id
}

resource "azurerm_subnet_network_security_group_association" "adb_dp_private" {
  subnet_id                 = azurerm_subnet.adb_dp_private.id
  network_security_group_id = azurerm_network_security_group.adb_dp.id
}


resource azurerm_subnet "adb_auth_private" {
    name                 = "${local.prefix}-adb-auth-private"
    resource_group_name  = var.rg
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = [cidrsubnet(var.cidr, 3, 1)]
  
    enforce_private_link_endpoint_network_policies = true
    enforce_private_link_service_network_policies  = true
  
    delegation {
      name = "databricks"
      service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    }
  
    service_endpoints = var.private_subnet_endpoints
}

resource azurerm_subnet "adb_auth_public" {
    name                 = "${local.prefix}-adb-auth-public"
    resource_group_name  = var.rg
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = [cidrsubnet(var.cidr, 3, 0)]
  
    delegation {
      name = "databricks"
      service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    }
}

resource azurerm_network_security_group "adb_auth" {
    name                = "${local.prefix}-adb-auth"
    location            = var.location
    resource_group_name = var.rg
    tags                = var.tags
#    tags                = merge(var.tags, {"environment"=${var.env}})
}

resource "azurerm_subnet_network_security_group_association" "adb_auth_public" {
  subnet_id                 = azurerm_subnet.adb_auth_public.id
  network_security_group_id = azurerm_network_security_group.adb_auth.id
}

resource "azurerm_subnet_network_security_group_association" "adb_auth_private" {
  subnet_id                 = azurerm_subnet.adb_auth_private.id
  network_security_group_id = azurerm_network_security_group.adb_auth.id
}

### databricks_workspace

resource "azurerm_databricks_workspace" "dp" {
  name                                  = "${local.prefix}-workspace-dp"
  resource_group_name                   = var.rg
  location                              = var.location
  sku                                   = "premium"
  managed_resource_group_name           = "${local.prefix}-workspace-dp-rg"
  tags                                  = local.tags
  public_network_access_enabled         = false
  network_security_group_rules_required = "NoAzureDatabricksRules"
  customer_managed_key_enabled          = true
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.main.id
    private_subnet_name                                  = azurerm_subnet.adb_dp_private.name
    public_subnet_name                                   = azurerm_subnet.adb_dp_public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.adb_dp_public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.adb_dp_private.id
    storage_account_name                                 = "dbfs"
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.adb_dp_public,
    azurerm_subnet_network_security_group_association.adb_dp_private
  ]
}

resource "azurerm_databricks_workspace" "auth" {
  name                                  = "${local.prefix}-workspace-auth"
  resource_group_name                   = var.rg
  location                              = var.location
  sku                                   = "premium"
  managed_resource_group_name           = "${local.prefix}-workspace-auth-rg"
  tags                                  = local.tags
  public_network_access_enabled         = false
  network_security_group_rules_required = "NoAzureDatabricksRules"
  customer_managed_key_enabled          = true
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.main.id
    private_subnet_name                                  = azurerm_subnet.adb_auth_private.name
    public_subnet_name                                   = azurerm_subnet.adb_auth_public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.adb_auth_public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.adb_auth_private.id
    storage_account_name                                 = "dbfs"
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.adb_auth_public,
    azurerm_subnet_network_security_group_association.adb_auth_private
  ]
}

### private endpoints
resource "azurerm_private_endpoint" "uiapi" {
    name                = "${local.prefix}-adb-dp-pe"
    location            = var.location
    resource_group_name = var.rg
    subnet_id           = azurerm_subnet.private_endpoints.id
    
    private_service_connection {
        name                           = "${local.prefix}-adb-dp-pe"
        private_connection_resource_id = azurerm_databricks_workspace.dp.id
        is_manual_connection           = false
        subresource_names              = ["databricks_ui_api"]
    }
    
    private_dns_zone_group {
        name                 = "private-dns-zone-uiapi"
        private_dns_zone_ids = [azurerm_private_dns_zone.databricks.id]
    }
}

resource "azurerm_private_dns_zone" "databricks" {
    name                = "privatelink.azuredatabricks.net"
    resource_group_name = var.rg
}

resource "azurerm_private_dns_zone_virtual_network_link" "databricks" {
    name                  = "${local.prefix}-adb-vnetlink"
    resource_group_name   = var.rg
    private_dns_zone_name = azurerm_private_dns_zone.databricks.name
    virtual_network_id    = azurerm_virtual_network.main.id
}

resource "azurerm_private_endpoint" "auth" {
    name                = "${local.prefix}-adb-auth-pe"
    location            = var.location
    resource_group_name = var.rg
    subnet_id           = azurerm_subnet.private_endpoints.id
  
    private_service_connection {
      name                           = "${local.prefix}-adb-auth-pe"
      private_connection_resource_id = azurerm_databricks_workspace.auth.id
      is_manual_connection           = false
      subresource_names              = ["browser_authentication"]
    }
  
    private_dns_zone_group {
      name                 = "private-dns-zone-auth"
      private_dns_zone_ids = [azurerm_private_dns_zone.databricks.id]
    }
}
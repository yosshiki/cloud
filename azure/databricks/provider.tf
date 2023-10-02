terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.58.0"
    }
  }
}

# backend "azurerm" {}

provider "azurerm" {
  features {}
}

provider "databricks" {
  alias      = "azure_account"
  host       = "https://accounts.azuredatabricks.net"
  account_id = "00000000-0000-0000-0000-000000000000"
  auth_type  = "azure-cli"
}

resource "databricks_service_principal" "sp" {
  provider       = databricks.azure_account
  application_id = "00000000-0000-0000-0000-000000000000"
}
# Azure Databricks IaC by Terraform 

## 認証  
  https://learn.microsoft.com/ja-jp/azure/databricks/dev-tools/service-prin-aad-token

## IaC
  https://learn.microsoft.com/ja-jp/azure/databricks/dev-tools/index-iac

## Databricks Terraform provider
- https://learn.microsoft.com/ja-jp/azure/databricks/dev-tools/terraform/
- workspace 作成後に使う
- 必要なもの
  - Azure account
  - Azure CLI
  - terraform CLI
  - Databricks CLI バージョン 0.200 以上
  - Azure Databricks Environmental Variable
    - DATABRICKS_HOST = https://dbc-1234567890123456.cloud.databricks.com
    - DATABRICKS_TOKEN
      - ref. https://learn.microsoft.com/ja-jp/azure/databricks/administration-guide/access-control/tokens

- providers.tf
```variable "databricks_connection_profile" {}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "azurerm" {
  features {}
}

# Use Databricks CLI authentication.
provider "databricks" {
  profile = var.databricks_connection_profile
}```

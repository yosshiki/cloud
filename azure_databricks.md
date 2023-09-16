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

1. create directory
   ```
   mkdir terraform_demo && cd terraform_demo
   ```
2. create auth.tf
   - A. use Azure CLI and authenticate by azure account, azure databricks account, azure databricks workspace via databricks CLI profile
   ```
   variable "databricks_connection_profile" {} 
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
   }
   ```
   - B. use Azure CLI and authenticate by azure account, azure databricks account, azure databricks workspace
   ```
   variable "databricks_host" {}
   
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
   
   # Use Azure CLI authentication.
   provider "databricks" {
     host = var.databricks_host
   }
   ```
   - C. use Azure CLI and authenticate by azure account, azure databricks account, use Environmental Variable and authenticate databricks workspace
   ```
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
    
    # Use environment variables for authentication.
    provider "databricks" {}
   ```
1. A and B, create auth.auto.tfvars
    - *.auto.tfvars ファイルを使用すると、コードとは別に変数値を指定できます。 これにより、さまざまな使用シナリオで .tf ファイルのモジュール性と再利用性が高くなります。
    - auth.auto.tfvars
      - A. use databricks CLI profile
      ```
      databricks_connection_profile = "DEFAULT"
      ```
      - B. use Azure CLI
      ```
      databricks_host = "https://<workspace-instance-name>"
      ```
1. 

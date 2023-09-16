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
1. `terraform init`
2. `terraform plan`
3. `terraform apply`

## Sample configuration  
https://learn.microsoft.com/ja-jp/azure/databricks/dev-tools/terraform/#sample-configuration  
1. create `me.tf`
   ```
   # Retrieve information about the current user.
   data "databricks_current_user" "me" {}
   ```
3. create `notebook.tf`
   ```
   variable "notebook_subdirectory" {
      description = "A name for the subdirectory to store the notebook."
      type        = string
      default     = "Terraform"
    }
    
    variable "notebook_filename" {
      description = "The notebook's filename."
      type        = string
    }
    
    variable "notebook_language" {
      description = "The language of the notebook."
      type        = string
    }
    
    resource "databricks_notebook" "this" {
      path     = "${data.databricks_current_user.me.home}/${var.notebook_subdirectory}/${var.notebook_filename}"
      language = var.notebook_language
      source   = "./${var.notebook_filename}"
    }
    
    output "notebook_url" {
     value = databricks_notebook.this.url
    }
   ```
1. create `notebook.auto.tfvars`
   ```
   notebook_subdirectory = "Terraform"
   notebook_filename     = "notebook-getting-started.py"
   notebook_language     = "PYTHON"
   ```
1. create `notebook-getting-started.py`
   ```
   display(spark.range(10))
   ```
1. create `cluster.tf`
   ```
   variable "cluster_name" {
      description = "A name for the cluster."
      type        = string
      default     = "My Cluster"
    }
    
    variable "cluster_autotermination_minutes" {
      description = "How many minutes before automatically terminating due to inactivity."
      type        = number
      default     = 60
    }
    
    variable "cluster_num_workers" {
      description = "The number of workers."
      type        = number
      default     = 1
    }
    
    # Create the cluster with the "smallest" amount
    # of resources allowed.
    data "databricks_node_type" "smallest" {
      local_disk = true
    }
    
    # Use the latest Databricks Runtime
    # Long Term Support (LTS) version.
    data "databricks_spark_version" "latest_lts" {
      long_term_support = true
    }
    
    resource "databricks_cluster" "this" {
      cluster_name            = var.cluster_name
      node_type_id            = data.databricks_node_type.smallest.id
      spark_version           = data.databricks_spark_version.latest_lts.id
      autotermination_minutes = var.cluster_autotermination_minutes
      num_workers             = var.cluster_num_workers
    }
    
    output "cluster_url" {
     value = databricks_cluster.this.url
    }
   ```
1. create `cluster.auto.tfvars`
   ```
   cluster_name                    = "My Cluster"
   cluster_autotermination_minutes = 60
   cluster_num_workers             = 1
   ```
1. create `job.tf`
   ```
   variable "job_name" {
      description = "A name for the job."
      type        = string
      default     = "My Job"
    }
    
    resource "databricks_job" "this" {
      name = var.job_name
      existing_cluster_id = databricks_cluster.this.cluster_id
      notebook_task {
        notebook_path = databricks_notebook.this.path
      }
      email_notifications {
        on_success = [ data.databricks_current_user.me.user_name ]
        on_failure = [ data.databricks_current_user.me.user_name ]
      }
    }
    
    output "job_url" {
      value = databricks_job.this.url
    }
   ```
1. create `job.auto.tfvars`
   ```
   job_name = "My Job"
   ```

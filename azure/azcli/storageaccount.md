https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal

```
NAME=
RESOURCEGROUP=
LOCATION=japaneast
SKU=Standard_GRS
KIND=StorageV2

az storage account create \
  --name ${NAME} \
  --resource-group ${RESOURCEGROUP} \
  --location ${LOCATION} \
  --sku ${SKU} \
  --kind ${KIND}
  
az storage account show \
    --resource-group ${RESOURCEGROUP} \
    --name ${NAME}
    
```

https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal

```
NAME=
RG=
LOCATION=japaneast
SKU=Standard_GRS
KIND=StorageV2


az storage account create \
  --name ${NAME} \
  -g ${RG} \
  --location ${LOCATION} \
  --sku ${SKU} \
  --kind ${KIND} 

az storage account network-rule add \
  -g ${RG} \
  --account-name ${NAME} \
  --ip-address 23.45.1.0/24 67.89.100.0/24

az storage account show \
    -g ${RG} \
    --name ${NAME}
```

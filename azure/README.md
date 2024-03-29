# azure
- [Architecture](https://github.com/yosshiki/cloud/blob/main/azure/README.md#Architecture)
- [references](https://github.com/yosshiki/cloud/blob/main/azure/README.md#references)
- [exams](https://github.com/yosshiki/cloud/blob/main/azure/README.md#exams)
  - [AZ-900](https://github.com/yosshiki/cloud/blob/main/azure/README.md#az-900)  
  - [AZ-104](https://github.com/yosshiki/cloud/blob/main/azure/README.md#az-104)  
  - [AZ-305](https://github.com/yosshiki/cloud/blob/main/azure/README.md#az-305)  
  - [SC-200](https://github.com/yosshiki/cloud/blob/main/azure/README.md#SC-200)  

alias
```
alias azlist='az account list --query [*].[name,id] -o tsv'
alias azset='az account set -s'
alias azwho='az account show --query [name,id] -o tsv'
```

## Architecture
|item|URL|
|---|---|
|Blue-Green-Deployment_for_AKS|https://learn.microsoft.com/ja-jp/azure/architecture/guide/aks/blue-green-deployment-for-aks|
|Networking and connectivity for mission-critical workloads on Azure|https://learn.microsoft.com/ja-jp/azure/well-architected/mission-critical/mission-critical-networking-connectivity|
|hostname-preservation|https://learn.microsoft.com/ja-jp/azure/architecture/best-practices/host-name-preservation|

## references
|item|URL|
|---|---|
|Microsoft Defender for Cloud pricing|https://azure.microsoft.com/ja-jp/pricing/details/defender-for-cloud/#purchase-options|
|Microsoft Defender for Resource Manager|https://learn.microsoft.com/ja-jp/azure/defender-for-cloud/defender-for-resource-manager-introduction|
|free plan|https://www.acrovision.jp/service/azure/?p=930|
|use templates|https://learn.microsoft.com/ja-jp/azure/templates/|
|resource provider|https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/management/azure-services-resource-providers|
|azure IaC 体験入隊|https://www.slideshare.net/ToruMakabe/azure-infrastructure-as-code|
|terraform|https://www.slideshare.net/ToruMakabe/hashicorp-228547998|
|Azure Resource Manager テンプレートにパラメーターと出力を追加する|https://learn.microsoft.com/ja-jp/training/modules/create-azure-resource-manager-template-vs-code/5-exercise-parameters-output?pivots=powershell|
|演習 - Azure Resource Manager テンプレートを作成してデプロイする|https://learn.microsoft.com/ja-jp/training/modules/create-azure-resource-manager-template-vs-code/3-exercise-create-and-deploy-template?pivots=powershell|
|Azure リソースへのアクセスをセキュリティで保護する|https://learn.microsoft.com/ja-jp/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/?WT.mc_id=learnlive-20221012L-JP%3FWT.mc_id%3Dlearnlive-20221012L-JP|

## private endpoint
|item|URL|
|---|---|
|private endpoint|https://learn.microsoft.com/ja-jp/azure/private-link/private-endpoint-overview|
|service endpoint vs private endpoint1|https://qiita.com/taka_s/items/340c9c52f1e948f0f753|
|service endpoint vs private endpoint2|https://zenn.dev/tomot/articles/89d561c36bc52c|
|private endpoint dns|https://learn.microsoft.com/ja-jp/azure/private-link/private-endpoint-dns?source=recommendations#azure-private-endpoint-dns-configuration|
|procedure|https://learn.microsoft.com/ja-jp/azure/private-link/create-private-endpoint-cli?tabs=dynamic-ip|
|private link|https://learn.microsoft.com/ja-jp/azure/private-link/private-link-overview|
|private link service|https://learn.microsoft.com/ja-jp/azure/private-link/private-link-service-overview|
|private link(mslearn)|https://learn.microsoft.com/ja-jp/training/modules/introduction-azure-private-link/|

## exams
### AZ-900
|item|URL|
|---|---|
|training(free)|https://www.microsoft.com/ja-jp/events/top/training-days|  
|mslearn(exam)|https://learn.microsoft.com/ja-jp/certifications/exams/az-900|  
  
### AZ-104  
|item|URL|
|---|---|
|MS account creation|https://signup.live.com|
|text| https://github.com/hiryamada/notes/tree/main/AZ-104|  
|mslearn1(exam)|https://learn.microsoft.com/ja-jp/certifications/exams/az-104|
|mslearn2(official collection)|https://learn.microsoft.com/ja-jp/users/msftofficialcurriculum-4292/collections/xe42fkkpzr6roe|
|mslearn3(training course)|https://learn.microsoft.com/ja-jp/training/courses/AZ-104T00|
|lab environment|https://esi.learnondemand.net|
|azure pass|https://micosoftazurepass.com|
|lab text|https://sakkuru.github.io/AZ-104-MicrosoftAzureAdministrator.ja-jp/|  
|lab files|https://github.com/MicrosoftLearning/AZ-104JA-MicrosoftAzureAdministrator/archive/master.zip|  

### AZ-305

|item|URL|
|---|---|
|Intelligent Cloud Challenge|https://learn.microsoft.com/ja-jp/users/cloudskillschallenge/collections/qdgnhgkz1r78?WT.mc_id=cloudskillschallenge_8db0f3ef-c6eb-4b6f-9db2-ce5c8c7e2ecc|


### SC-200
|item|URL|
|---|---|
|mslearn(exam)|https://learn.microsoft.com/ja-jp/certifications/exams/sc-200|
|sentinel|https://learn.microsoft.com/ja-jp/training/paths/sc-200-configure-azure-sentinel-environment/|
|Protect Everything Challenge|https://learn.microsoft.com/ja-jp/users/cloudskillschallenge/collections/w2gkho113y7w?WT.mc_id=cloudskillschallenge_7a06394f-6963-44b8-b21c-807c0079fe38|

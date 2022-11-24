変数設定(az cli)  
```
az functionapp config appsettings set --name MyFunctionApp --resource-group MyResourceGroup --settings "AzureWebJobsStorage=$storageConnectionString"
az functionapp config appsettings set --name iam-inventory --resource-group rg01 --settings "TTEST=testtest"
```
変数設定(powershell)  
```
Update-AzFunctionAppSetting -Name iam-inventory -ResourceGroupName rg01 -AppSetting @{"TTTEST" = "testtesttest"}
```  
yaml
```
variables:
- name: serviceconnection
  value: 'my service connection'
```

function 内での使用方法
```
echo $env:TTEST
echo $env:TTTEST
```

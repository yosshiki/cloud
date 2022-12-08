## resource   

|no.   |resource  |depends|remark|
| ---- | ---- | ---- | ---- |
|1|networkInterfaces|VNET, NSG, PIP|-|
|2|virtualNetworks|-|-|
|3|PIP|-|-|
|4|NSG|-|-|
|5|storageAccounts|-|-|
|6|virtualMachines|NIC, storageAccounts|bootDiagnostics:enabled|

## variables in parameters.json
|no.   |item  |value|remark|
| ---- | ---- | ----|---- |  
|1|adminUsername|Student||
|2|adminPassword|Pa67w.rd432!||
|3|vmNamePrefix|test-vm-vm||
|4|nicNamePrefix|test-vm-nic||
|5|imagePublisher|MicrosoftWindowsServer||
|6|imageOffer|WindowsServer||
|7|imageSKU|2019-Datacenter||
|8|vmSize|Standard_D2s_v3||
|9|virtualNetworkName|test-vm-vnet||
|10|addressPrefix|10.0.0.0/24||
|11|virtualNetworkResourceGroup|test-vm-rg0||
|12|subnet0Name|subnet0||
|13|subnet0Prefix|10.0.0.0/26||

## variables in templates.json only fixes
|no.   |item  |value|remark|
| ---- | ---- | ----|---- |  
|1|storageAccountName|'test-storageAccount'+subscriptionId||
|2|storageAccountType|Standard_LRS||
|3|numberOfInstances|1||
|4|computeAPIVersion|2018-10-01||
|5|networkAPIVersion|2018-12-01||
|6|storageAPIVersion|2019-04-01||
|7|NIC's ipConfigurations.name|ipconfig1||
|8|privateIPAllocationMethod|Dynamic||
|9|PublicIpAddresses.copy.name|pipLoop||
|10|PublicIpAddresses.properties.publicIpAllocationMethod|Dynamic||
|11|NSG's properties.securityRules.name|default-allow-rdp||
|12|NSG's properties.securityRules.properties|||
|13|storageProfile.imageReference.version|latest||
|14|osDisk.createOption|FromImage||
|15|osDisk.version|osDisk.managedDisk.storageAccountType||
|16|diagnosticsProfile.bootDiagnostics.enabled|true|||

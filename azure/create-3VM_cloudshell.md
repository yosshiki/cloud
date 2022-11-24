https://learn.microsoft.com/ja-jp/training/modules/automate-azure-tasks-with-powershell/8-exercise-create-resource-using-script

1. create a powershell script

```
cd $HOME\clouddrive
touch "./ConferenceDailyReset.ps1"
code "./ConferenceDailyReset.ps1"
```

2. code  
```
param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}
```

WARNING: Upcoming breaking changes in the cmdlet 'New-AzVM' :                                           
Starting in May 2023 the "New-AzVM" cmdlet will deploy with the Trusted Launch configuration by default. To know more about Trusted Launch, please visit https://docs.microsoft.com/en-us/azure/virtual-machines/trusted-launch  

It is recommended to use parameter "-PublicIpSku Standard" in order to create a new VM with a Standard public IP.Specifying zone(s) using the "-Zone" parameter will also result in a Standard public IP.If "-Zone" and "-PublicIpSku" are not specified, the VM will be created with a Basic public IP instead.Please note that the Standard SKU IPs will become the default behavior for VM creation in the future  as
Note : Go to https://aka.ms/azps-changewarnings for steps to suppress this breaking change warning, and other information on breaking changes in Azure PowerShell.  

3. run the script  
!!! credential !!!
     | The supplied password must be between 6-72 characters long and must satisfy at least 3 of        
     | password complexity requirements from the following: 1) Contains an uppercase character 2)       
     | Contains a lowercase character 3) Contains a numeric digit 4) Contains a special character 5)    
s     | Control characters are not allowed
```
$resourceGroup="your resource group"
./ConferenceDailyReset.ps1 $resourceGroup
```

4. check  
```
Get-AzResource -ResourceType Microsoft.Compute/virtualMachines
```

result example  
```
> Get-AzResource -ResourceType Microsoft.Compute/virtualMachines

Name              : ConferenceDemo3
ResourceGroupName : learn-955a6b4f-d915-4c4d-96b7-2a76227f746d
ResourceType      : Microsoft.Compute/virtualMachines
Location          : westus
ResourceId        : /subscriptions/02dd49b6-b1df-4b19-bce6-b6188492ff0b/resourceGroups/learn-955a6b4f-d
                    915-4c4d-96b7-2a76227f746d/providers/Microsoft.Compute/virtualMachines/ConferenceDe
                    mo3
Tags              : 

Name              : ConferenceDemo2
ResourceGroupName : learn-955a6b4f-d915-4c4d-96b7-2a76227f746d
ResourceType      : Microsoft.Compute/virtualMachines
Location          : westus
ResourceId        : /subscriptions/02dd49b6-b1df-4b19-bce6-b6188492ff0b/resourceGroups/learn-955a6b4f-d
                    915-4c4d-96b7-2a76227f746d/providers/Microsoft.Compute/virtualMachines/ConferenceDe
                    mo2
Tags              : 

Name              : ConferenceDemo1
ResourceGroupName : learn-955a6b4f-d915-4c4d-96b7-2a76227f746d
ResourceType      : Microsoft.Compute/virtualMachines
Location          : westus
ResourceId        : /subscriptions/02dd49b6-b1df-4b19-bce6-b6188492ff0b/resourceGroups/learn-955a6b4f-d
                    915-4c4d-96b7-2a76227f746d/providers/Microsoft.Compute/virtualMachines/ConferenceDe
                    mo1
Tags              : 


PS /home/XXXXXX/clouddrive> 
```

5. cleanup
```
Remove-AzResourceGroup -Name MyResourceGroupName
```

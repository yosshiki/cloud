<# 
https://learn.microsoft.com/ja-jp/training/modules/automate-azure-tasks-with-powershell/8-exercise-create-resource-using-script 

The supplied password must be between 6-72 characters long and must satisfy at least 3 of        
     | password complexity requirements from the following: 1) Contains an uppercase character 2)       
     | Contains a lowercase character 3) Contains a numeric digit 4) Contains a special character 5)    
     | Control characters are not allowed
#>
param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}

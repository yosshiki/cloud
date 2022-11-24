# install azure powershell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
Install-Module -Name Az -Repository PSGallery -Force
Update-Module -Name Az

# connect
Connect-AzAccount

# list subscription
Get-AzSubscription

# list resource groups
Get-AzResourceGroup | Format-Table 

# create new resource group
New-AzResourceGroup -Name <name> -Location <location>

# List PublicIpAddress
Install-Module -Name Az.Network -Scope CurrentUser -Repository PSGallery -Force
Get-AzPublicIpAddress

# create new PublicIpAddress
$publicIpName = "test-public-ip"
# $publicIpName = "testvm-01"
$rgName="rg01"
$AllocationMethod="Static"
$dnsPrefix="test"+(Get-Date).ToString('MMdd')
$location="japaneast"

$publicIp = New-AzPublicIpAddress `
            -Name $publicIpName `
            -ResourceGroupName $rgName `
            -AllocationMethod $AllocationMethod `
            -DomainNameLabel $dnsPrefix `
            -Location $location

# confirm
$publicIp
$publicIp.IpAddress
(Get-AzPublicIpAddress -Name $publicIpName).IpAddress

### create new VM ###
$RESOURCEGROUP="rg01"
$NAME="testvm-jpe-01"
$LOCATION="japaneast"
$IMAGE="UbuntuLTS"
$PORT=22
$PUBLICIPADDRESSNAME="testvm-01"

# https://www.oct-wave.com/?p=158 #
$pass = "Test"+(Get-Date).ToString('MMdd')
$secureword = ConvertTo-SecureString $pass -AsPlainText -Force
$encryptword = ConvertFrom-SecureString -SecureString $secureword
$encryptword > pass.dat

$securePass = Get-Content .\pass.dat | ConvertTo-SecureString
$credentialObj = New-Object System.Management.Automation.PsCredential "azureuser",$securePass

# create new VM #
$vm = New-AzVm -ResourceGroupName $RESOURCEGROUP `
         -Name $NAME `
         -Credential $credentialObj `
         -Location $LOCATION `
         -Image $IMAGE `
         -OpenPorts $PORT `
         -PublicIpAddressName $PUBLICIPADDRESSNAME

# NIC confirm #
get-AzNetworkInterface 
Remove-AzNetworkInterface -ResourceGroupName $RESOURCEGROUP -name testvm-jpe-01

# confirm
Get-AzVM
Get-AzResourceGroup | Format-Table

# deletion
Remove-AzVM -Name $NAME -ResourceGroupName $RESOURCEGROUP
Get-AzVM

Remove-AzPublicIpAddress -Name $PUBLICIPADDRESSNAME -ResourceGroupName $RESOURCEGROUP
Get-AzPublicIpAddress

# disk deletion
Get-AzDisk -ResourceGroupName
Remove-AzDisk -Force -Name (Get-AzDisk -ResourceGroupName $RESOURCEGROUP).ResourceGroupName -ResourceGroupName $RESOURCEGROUP

# vnet deletion
Get-AzVirtualNetwork -ResourceGroupName $RESOURCEGROUP
Remove-AzVirtualNetwork -Force -Name $RESOURCEGROUP -ResourceGroupName $RESOURCEGROUP
Remove-AzVirtualNetwork -ResourceGroupName $RESOURCEGROUP -name $vnet_name

# NSG deletion
Get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroup
(get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroup).name
Remove-AzNetworkSecurityGroup -Force -Name 
Remove-AzNetworkSecurityGroup -Force -Name "testvm-jpe-01" -ResourceGroupName $Resourcegroup

# public IP アドレス deletion
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
Remove-AzPublicIpAddress -Force -ResourceGroupName $ResourceGroup -name "testvm-jpe-01"
Remove-AzPublicIpAddress -Force


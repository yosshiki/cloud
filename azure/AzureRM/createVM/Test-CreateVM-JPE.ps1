$location = 'japaneast'
$rgName = 'test-createVM-rg0'
New-AzResourceGroup -Name $rgName -Location $location
New-AzResourceGroupDeployment `
   -ResourceGroupName $rgName `
   -TemplateFile $HOME/test-vm-template.json `
   -TemplateParameterFile $HOME/test-vm-parameters.json `
   -AsJob

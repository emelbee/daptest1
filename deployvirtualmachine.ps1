New-AzResourceGroup `
   -ResourceGroupName "myResourceGroupVM" `
   -Location "East US"
 
   
  
  $username = "breakglass"
  $password = ConvertTo-SecureString "P@ssW0rD!" -AsPlainText -Force
  $Cred = New-Object System.Management.Automation.PSCredential($username, $password)
  
     

New-AzVm `
    -ResourceGroupName "myResourceGroupVM" `
    -Name "myVM" `
    -Location "East US" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389,139,445 `
    -Credential $Cred 

#Write-Host myPublicIPAddress = $myPublicIPAddress
echo ##vso[task.setvariable variable=mypublicipaddress]$myPublicIPAddress

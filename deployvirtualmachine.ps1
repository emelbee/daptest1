New-AzResourceGroup `
   -ResourceGroupName "myResourceGroupVM" `
   -Location "EastUS"
   
  #$password = ConvertTo-SecureString “TestTestTest12345!” -AsPlainText -Force
  #$Cred = New-Object System.Management.Automation.PSCredential (“forceduser”, $password)
  
  $Cred = Get-Credential
  
 New-AzVm `
   -ResourceGroupName "myResourceGroupVM" `
   -Name "myVM" `
   -Location "EastUS" `
   -VirtualNetworkName "myVnet" `
   -SubnetName "mySubnet" `
   -SecurityGroupName "myNetworkSecurityGroup" `
   -PublicIpAddressName "myPublicIpAddress" `
   -Credential $Cred

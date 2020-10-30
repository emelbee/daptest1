New-AzResourceGroup `
   -ResourceGroupName "myResourceGroupVM" `
   -Location "East US"
   -Force
   
  
  $username = "newuser"
  $password = ConvertTo-SecureString "mypassword" -AsPlainText -Force
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password) -Force
      
 #New-AzVm `
  #-ResourceGroupName "myResourceGroupVM" `
   #-Name "myVM" `
   #-Location "East US" `
   #-VirtualNetworkName "myVnet" `
   #-SubnetName "mySubnet" `
   #-SecurityGroupName "myNetworkSecurityGroup" `
   #-PublicIpAddressName "myPublicIpAddress" `
   #-Credential $Cred
   #-Force


New-AzVm `
    -ResourceGroupName "myResourceGroupVM" `
    -Name "myVM" `
    -Location "East US" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389 `
    -Credential $Cred `
    -Force

New-AzResourceGroup 
   -ResourceGroupName "myResourceGroupVM" 
   -Location "East US"
   
  #$password = ConvertTo-SecureString “TestTestTest12345!” -AsPlainText -Force
  #$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList (“forceduser” , $password)
  
  
  $username = "newuser"
  $password = ConvertTo-SecureString "mypassword" -AsPlainText -Force
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password) -Force
      
 New-AzVm 
   -ResourceGroupName "myResourceGroupVM" 
   -Name "myVM" 
   -Location "East US" 
   -VirtualNetworkName "myVnet" 
   -SubnetName "mySubnet" 
   -SecurityGroupName "myNetworkSecurityGroup" 
   -PublicIpAddressName "myPublicIpAddress" 
   -Credential $Cred

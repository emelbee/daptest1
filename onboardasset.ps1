# Define the FQDN for the REST APIs
$FQDN = 'https://components.cybr.com'

# get the api logon credentials

  # We got the creds for the REST APIs so we are good to go!
  "$(Get-Date) Credentials retrieved, logging in to REST APIs"

$logonInfo = @{}

  #$logonInfo.username = $username
  #$logonInfo.password = $password
  $logonInfo.username = $(env:VAULT-USERNAME)
  $logonInfo.password = $(env:VAULT-PASSWORD)

# test input
$myPublicIpAddress = "1.1.1.1"
$username = "test"
$password = "test"
 "$(Get-Date) test input done "
##########################################################
  # Use REST APIs to logon to the CyberArk Vault
  ##########################################################
  $loginURI = $FQDN + '/PasswordVault/WebServices/auth/cyberark/CyberArkAuthenticationService.svc/logon'
  #login to the Vault
  $result = Invoke-RestMethod -Method Post -Uri $loginURI -ContentType "application/json" -Body (ConvertTo-Json($logonInfo))
  "$(Get-Date) Vault login successful"
  $logonToken = $result.CyberArkLogonResult
  # Define the Account Management URL
  $createAccountURI = $FQDN + '/PasswordVault/WebServices/PIMServices.svc/Account'
  # Account parameters
  $newAccounts = @{}
  $newAccount = @{}
  $newAccount.safe = "Azure"
  $newAccount.platformID = "AzureWindowsServerAccounts"
  # We could use the IP or DNS address, IP is neater...
  $newAccount.address = $myPublicIpAddress
  #$newAccount.address = $publicDNS
  # The default Windows account is always Administrator...
  $newAccount.username = $username
  $newAccount.password = $password
  $newAccount.accountName = $instanceid
  # Add the account to create to the accounts array
  $newAccounts.account = $newAccount
  # Set the authorisation token in the headers for the REST call
  $headers = @{ "Authorization" = $logonToken }
  ##########################################################
  # Use REST APIs to create the account in the CyberArk Vault
  ##########################################################
  $result = Invoke-RestMethod -Method Post -Uri $createAccountURI -headers $headers -ContentType "application/json" -Body (ConvertTo-Json($newAccounts))
  "$(Get-Date) Account created successfully" 
  ##########################################################
  # Use REST APIs to logoff from the Vault
  ##########################################################
  $logoffURI = $FQDN + '/PasswordVault/WebServices/auth/cyberark/CyberArkAuthenticationService.svc/logoff'
 # $result = Invoke-RestMethod -Method Post -Uri $logoffURI -headers $headers -ContentType "application/json" -Body (ConvertTo-Json($logonInfo))
 # "$(Get-Date) Vault logoff successful"
 # "$(Get-Date) Finished provisioning instance in AWS and the privileged account of instance $instanceid, with IP address $publicIP in the CyberArk Vault"
 # pause
  # Clear AWS credentials so no PowerShell script in the same context can access them
 # Remove-AWSCredentialProfile -ProfileName default -Force
  # This will delete the only way you can decrypt the password using AWS provided capabilities
 # Remove-Item "$KeyFilePath"
#}

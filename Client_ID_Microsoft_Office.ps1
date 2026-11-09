$clientId    = "d3590ed6-52b3-4102-aeff-aad2292ab01c"
$redirectUri = "ms-appx-web://Microsoft.AAD.BrokerPlugin/d3590ed6-52b3-4102-aeff-aad2292ab01c"
$scope       = "https://graph.microsoft.com/.default offline_access"

$Url = "https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&state=9gaPNizkzgtisKqA&scope=$scope&client_info=1"
$Url += '&claims={"access_token": {"xms_cc": {"values": ["CP1"]}}}'
Start-Process $Url

Write-Host "Open Browser dev tools, authenticate and grab the CODE parameter from the redirect URL"
$codeValue = Read-Host "Enter content of CODE parameter"

$Headers = @{
    "User-Agent"   = "python-requests/2.32.3"
    "X-Client-Sku" = "MSAL.Python"
    "X-Client-Ver" = "1.31.0"
    "X-Client-Os"  = "win32"
}

$Body = @{
    grant_type   = "authorization_code"
    client_id    = $clientId
    scope        = $scope
    code         = $codeValue
    redirect_uri = $redirectUri
    client_info  = 1
    claims       = '{"access_token": {"xms_cc": {"values": ["CP1"]}}}'
}

$tokens = Invoke-RestMethod 'https://login.microsoftonline.com/organizations/oauth2/v2.0/token' -Method POST -Body $Body -Headers $Headers
Write-Host 'Tokens stored in Variable $tokens'
$tokens

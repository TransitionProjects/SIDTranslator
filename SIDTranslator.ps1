function get-UserFromSID {
    $inputSID = Read-Host -Prompt "Enter an SID to translate"
    $SID = New-Object System.Security.Principal.SecurityIdentifier ($inputSID)
    $userObject = $SID.Translate([System.Security.Principal.NTAccount]) 
    Write-Host 'The friendly name of this SID is' $userObject.Value
}

function get-SIDFromUser {
$inputUserObject = Read-Host -Prompt "Enter a pre-windows-2000 logon name to translate"
$userObject = New-Object System.Security.Principal.NTAccount($inputUserObject)
$SID = $userObject.Translate([System.Security.Principal.SecurityIdentifier])
Write-Host 'The SID of this User is' $SID.Value
}

function reset-shell {
    exit 
}

function invoke-mainmenu {
    Clear-Host
    Write-Host ':::::::::::::::::::SID Translator:::::::::::::::::::' -ForegroundColor Green
    Write-Host '[1] Get username from SID' -ForegroundColor Yellow
    Write-Host '[2] Get SID from Username' -ForegroundColor Yellow
    Write-Host '[Q] Quit' -ForegroundColor Yellow
    $mainMenuInput = Read-Host -Prompt "Enter an option above to continue"
    switch ($mainMenuInput) {
        1 {get-UserFromSID}
        2 {get-SIDFromUser}
        Q {reset-shell}
        Default {invoke-mainmenu}
    }
}

invoke-mainmenu
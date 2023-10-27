function get-UserFromSID {
    $inputSID = Read-Host -Prompt "Enter an SID to translate"
    $SID = New-Object System.Security.Principal.SecurityIdentifier ($inputSID)

    try {$userObject = $SID.Translate([System.Security.Principal.NTAccount])}
    catch {Write-Host "User not found" -ForegroundColor Red}
    
    if ($userObject.Value) {
        Write-Host 'The friendly name of this SID is' $userObject.Value -ForegroundColor Green
    }
}

function get-SIDFromUser {
$inputUserObject = Read-Host -Prompt "Enter a pre-windows-2000 logon name to translate"
$userObject = New-Object System.Security.Principal.NTAccount($inputUserObject)
$SID = $userObject.Translate([System.Security.Principal.SecurityIdentifier])
Write-Host 'The SID of this User is' $SID.Value -ForegroundColor Green
}

function reset-shell {
    exit
}

function Invoke-ContinueMenu {
    $continueInput = Read-Host -Prompt "Search another? (Y\N)"
    switch ($continueInput) {
        Y {invoke-mainmenu}
        N {exit}
        Default {invoke-continuemenu}
    }
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
    Invoke-ContinueMenu
}

invoke-mainmenu
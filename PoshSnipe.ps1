<#
.NAME
    PowerSnipe
#>
#Error handling
$ErrorActionPreference = "SilentlyContinue"

# Get current public IP and declare the first substring cut location in the world time API's index
$ip = (Invoke-RestMethod http://ipinfo.io/json).ip
$timeSubstringFirstCut = 60 + $ip.Length

#Import GUI
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(730,400)
$Form.text                       = "PoshSniper"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#00c1ff")

$title                           = New-Object system.Windows.Forms.Label
$title.text                      = "[Power Snipe]"
$title.AutoSize                  = $true
$title.width                     = 245
$title.height                    = 26
$title.location                  = New-Object System.Drawing.Point(270,10)
$title.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',20,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))
$title.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$by                              = New-Object system.Windows.Forms.Label
$by.text                         = "Coded by Altoid0"
$by.AutoSize                     = $true
$by.width                        = 25
$by.height                       = 10
$by.location                     = New-Object System.Drawing.Point(295,48)
$by.Font                         = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$CNameText                       = New-Object system.Windows.Forms.TextBox
$CNameText.multiline             = $false
$CNameText.width                 = 150
$CNameText.height                = 20
$CNameText.location              = New-Object System.Drawing.Point(51,121)
$CNameText.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$CNameLabel                      = New-Object system.Windows.Forms.Label
$CNameLabel.text                 = "Current Name"
$CNameLabel.AutoSize             = $true
$CNameLabel.width                = 25
$CNameLabel.height               = 10
$CNameLabel.location             = New-Object System.Drawing.Point(76,99)
$CNameLabel.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',11)

$TNameLabel                      = New-Object system.Windows.Forms.Label
$TNameLabel.text                 = "Target Name"
$TNameLabel.AutoSize             = $true
$TNameLabel.width                = 25
$TNameLabel.height               = 10
$TNameLabel.location             = New-Object System.Drawing.Point(322,99)
$TNameLabel.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',11)

$TNameText                       = New-Object system.Windows.Forms.TextBox
$TNameText.multiline             = $false
$TNameText.width                 = 150
$TNameText.height                = 20
$TNameText.location              = New-Object System.Drawing.Point(293,121)
$TNameText.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$AccPassLabel                    = New-Object system.Windows.Forms.Label
$AccPassLabel.text               = "Account Password"
$AccPassLabel.AutoSize           = $true
$AccPassLabel.width              = 25
$AccPassLabel.height             = 10
$AccPassLabel.location           = New-Object System.Drawing.Point(544,99)
$AccPassLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',11)

$AccPassText                     = New-Object system.Windows.Forms.TextBox
$AccPassText.multiline           = $false
$AccPassText.width               = 150
$AccPassText.height              = 20
$AccPassText.location            = New-Object System.Drawing.Point(533,121)
$AccPassText.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TimeAvailabilityLabel           = New-Object system.Windows.Forms.Label
$TimeAvailabilityLabel.text      = "Time of Availability Ex. 22:34:28"
$TimeAvailabilityLabel.AutoSize  = $true
$TimeAvailabilityLabel.width     = 25
$TimeAvailabilityLabel.height    = 10
$TimeAvailabilityLabel.location  = New-Object System.Drawing.Point(264,181)
$TimeAvailabilityLabel.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',11)

$TimeAvailabilityText            = New-Object system.Windows.Forms.TextBox
$TimeAvailabilityText.multiline  = $false
$TimeAvailabilityText.width      = 150
$TimeAvailabilityText.height     = 20
$TimeAvailabilityText.location   = New-Object System.Drawing.Point(296,206)
$TimeAvailabilityText.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$BearerLabel                     = New-Object system.Windows.Forms.Label
$BearerLabel.text                = "Bearer Token"
$BearerLabel.AutoSize            = $true
$BearerLabel.width               = 25
$BearerLabel.height              = 10
$BearerLabel.location            = New-Object System.Drawing.Point(322,253)
$BearerLabel.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',11)

$BearerText                      = New-Object system.Windows.Forms.TextBox
$BearerText.multiline            = $false
$BearerText.width                = 662
$BearerText.height               = 20
$BearerText.location             = New-Object System.Drawing.Point(27,280)
$BearerText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',8)

$SnipeButton                     = New-Object system.Windows.Forms.Button
$SnipeButton.text                = "Load Sniper"
$SnipeButton.width               = 123
$SnipeButton.height              = 40
$SnipeButton.location            = New-Object System.Drawing.Point(309,315)
$SnipeButton.Font                = New-Object System.Drawing.Font('Matura MT Script Capitals',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$SnipeButton.ForeColor           = [System.Drawing.ColorTranslator]::FromHtml("")
$SnipeButton.BackColor           = [System.Drawing.ColorTranslator]::FromHtml("#7900f2")

$Form.controls.AddRange(@($title,$by,$CNameText,$CNameLabel,$TNameLabel,$TNameText,$AccPassLabel,$AccPassText,$TimeAvailabilityLabel,$TimeAvailabilityText,$BearerLabel,$BearerText,$SnipeButton))

$SnipeButton.Add_Click({ Start-Snipe })

function Get-CurrentTime {
    $currentTime = (Invoke-WebRequest http://worldtimeapi.org/api/ip).Content.Substring($timeSubstringFirstCut,8)
    return $currentTime
}
function Start-Snipe {
    #Coversion of GUI variables to simpler variables for function
    $bearer = ("Bearer " + $BearerText.text).ToString()
    $userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
    $currentName = ($CNameText.text).ToString()
    $TimeofAvailability = $TimeAvailabilityText.text

    #Get UUID from Mojang API
    $mojangRequest = Invoke-WebRequest https://api.mojang.com/user/profile/agent/minecraft/name/$currentName

    #Parsing response from Mojang API
    $firstCut = 17 + $currentName.Length
    $uuid = ($mojangRequest.content).Substring($firstCut,32)

    # Subtract 1 second from user provided drop time
    <#
    $splitTime = $TimeofAvailability.Split(":")
    $splitSeconds = [int]$splitTime[2] - 1
    # Concatinate 0 infront if needed
    if ($splitSeconds -lt 10) {
        $splitTime[2] = "0"+$splitSeconds.ToString()
    }
    else {
        $splitTime[2] = $splitSeconds.ToString()
    }
    # Combine String
    $TimeofAvailability = $splitTime[0] + ":" + $splitTime[1] + ":" + $splitTime[2]
    #>

    #Headers for POST request
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $bearer)
    $headers.Add("User-Agent", $userAgent)

    #Json for body
    $json = @{
        "name" = $TNameText.text
        "password" = $AccPassText.text
    } | ConvertTo-Json

    Do{
        # Write-Host "Preparing for snipe..."
        $compareTime = Get-CurrentTime
    } until($compareTime -eq $TimeofAvailability)

    # Spam POST requests 
    for ($i = 0; $i -lt 3; $i++) {
        Invoke-RestMethod -Uri https://api.mojang.com/user/profile/$uuid/name -Headers $headers -Method Post -Body $json -ContentType 'application/json'
    }
    $nameHistory = Invoke-WebRequest https://api.mojang.com/user/profiles/$uuid/names
    $nameHistory = $nameHistory.Content.ToString()
    if ($nameHistory -match $TNameText.Text) {
        Write-Host 'Name has been sniped'
    }

    else {
        Write-Host "Name has not been sniped or Mojang's API is delayed"
    }
}
[void]$Form.ShowDialog()

# (Invoke-RestMethod http://ipinfo.io/json).ip
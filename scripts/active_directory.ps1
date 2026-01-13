############################################################
# LABB-NOTERINGAR
# Ny domän: Grupp85.ps
# Maskiner: DC03 (server) + KLIENT03 (klient)
#
# Jag kör inte exakt allt i ett svep.
# Jag kör koden beroende på vilken maskin jag är på.
############################################################


# =============================================
# 1) EXPORT från gamla AD (körs på gamla DC:n)
# =================================================

# AD-modulen måste finnas annars funkar inte Get-ADUser osv.
Import-Module ActiveDirectory

# Exporterar: Name, SamAccountName + Grupp (en rad per grupp)
#Följt dessa guider: 
#https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-aduser?view=windowsserver2025-ps
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.5

New-Item -Path "C:\Temp" -ItemType Directory -Force

Get-ADUser -Filter * -Properties MemberOf |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
ForEach-Object {
    foreach ($g in $_.MemberOf) {
        [PSCustomObject]@{
            Name           = $_.Name
            SamAccountName = $_.SamAccountName
            Group          = (Get-ADGroup $g).Name
        }
    }
} |
Export-Csv "C:\Temp\Users_With_Groups.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ';'

# (Jag kollade att filen skapades)
dir C:\Temp\Users_With_Groups.csv



# =======================================================
# 2) GRUNDSETUP (körs på DC03 och KLIENT03 var för sig)
# =====================================================

# Jag stängde av IPv6 i labben för att slippa konstigt DNS/AD-strul
Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6

# Måste kunna köra scripts =)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Windows Update via PSWindowsUpdate 
#Följt Guide: https://www.youtube.com/watch?v=M2mMQfPGZsE
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate
Add-WUServiceManager -MicrosoftUpdate

Get-WindowsUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot |
Out-File "C:\$($env:COMPUTERNAME)-$(Get-Date -f yyyy-MM-dd)-MSUpdates.log" -Force



# ==================================================
# 2.1) SÄTTA IP
# ==================================================

# Jag kollade vilket InterfaceIndex jag hade innan jag satte IP
Get-NetAdapter | Select Name, ifIndex, Status

# --- KÖRS PÅ KLIENT03 ---
#IP + DNS mot DC (så den kan hitta domänen)
New-NetIPAddress -InterfaceIndex 5 -IPAddress 192.168.85.14 -PrefixLength 24 -DefaultGateway 192.168.85.1
Set-DnsClientServerAddress -InterfaceIndex 5 -ServerAddresses 192.168.85.11
ipconfig /all

# --- KÖRS PÅ DC03 ---
New-NetIPAddress -InterfaceIndex 13 -IPAddress 192.168.85.13 -PrefixLength 24 -DefaultGateway 192.168.85.1
Set-DnsClientServerAddress -InterfaceIndex 13 -ServerAddresses 192.168.85.11
ipconfig /all



# ===============================================
# 2.2) BYTA NAMN (körs på respektive maskin)
# ==============================================
hostname

# KÖR PÅ DC03:
Rename-Computer -NewName "DC03" -Restart

# KÖR PÅ KLIENT03:
Rename-Computer -NewName "KLIENT03" -Restart



# =========================================================
# 3) DC03: INSTALLERAR AD DS + DNS + skapa ny forest/domän
# ========================================================

# KÖR ENDAST PÅ DC03

Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools

# Skapar ny forest + domän (detta är “första DC:n”)
Install-ADDSForest -DomainName "Grupp85.ps" -DomainNetbiosName "GRUPP85"

# Efter reboot kollade jag att AD kom upp och att DNS fanns i Server Manager



# ===============================
# 4) KLIENT03: JOINA DOMÄNEN
# ====================================

# KÖRS ENDAST PÅ KLIENT03 (när DC03 är klar)

Add-Computer -DomainName "Grupp85.ps" -Restart

# Efter reboot körde jag detta:
Test-ComputerSecureChannel
# (i mitt fall fick jag True)



# ============================================
# 5) DC03: FILSERVER (disk + shares)
# ========================================

# KÖR PÅ DC03

Get-Disk

# Dubbelkollar storlek/nummer innan jag kör partition + format.
New-Partition -DiskNumber 0 -Size 60GB -AssignDriveLetter |
Format-Volume -FileSystem NTFS -NewFileSystemLabel "FileData" -Confirm:$false


# Skapar mappar först
New-Item -Path "E:\Home" -ItemType Directory -Force 
New-Item -Path "E:\Gruppkataloger" -ItemType Directory -Force 

# Shares: NTFS styr åtkomst
New-SmbShare -Name "Home$" -Path "E:\Home" -ChangeAccess "Authenticated Users" -FullAccess "Administrators"

New-SmbShare -Name "Gruppkatalog$" -Path "E:\Gruppkataloger" -ChangeAccess "Authenticated Users" -FullAccess "Administrators"


# =============================================================
# 6) DC03: OU + GRUPPER + GPO-länkar
# ============================================================

# KÖR PÅ DC03

Import-Module ActiveDirectory
Import-Module GroupPolicy

# OU-struktur
New-ADOrganizationalUnit -Name "Företaget" -Path "DC=Grupp85,DC=ps"

New-ADOrganizationalUnit -Name "Anställda"    -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADOrganizationalUnit -Name "Ekonomi"      -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADOrganizationalUnit -Name "Ledning"      -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADOrganizationalUnit -Name "Försäljning"  -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADOrganizationalUnit -Name "Projektgrupp" -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADOrganizationalUnit -Name "Mallar"       -Path "OU=Företaget,DC=Grupp85,DC=ps"

# Security groups (matchar NTFS-rättigheterna jag satte)  
New-ADGroup -Name "Ekonomi"      -GroupScope Global -GroupCategory Security -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADGroup -Name "Anstallda"    -GroupScope Global -GroupCategory Security -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADGroup -Name "Ledning"      -GroupScope Global -GroupCategory Security -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADGroup -Name "Forsaljning"  -GroupScope Global -GroupCategory Security -Path "OU=Företaget,DC=Grupp85,DC=ps"
New-ADGroup -Name "Projektgrupp" -GroupScope Global -GroupCategory Security -Path "OU=Företaget,DC=Grupp85,DC=ps"

# GPO-objekt (själva inställningarna gör jag sen)  
New-GPO -Name "Drive_Mapping"
New-GPO -Name "Folder_Redirection"
New-GPO -Name "Password_Policy_Login"
New-GPO -Name "LOGIN_GPO"

# Länkar dem till Företaget-OU
New-GPLink -Name "Drive_Mapping"         -Target "OU=Företaget,DC=Grupp85,DC=ps"
New-GPLink -Name "Folder_Redirection"    -Target "OU=Företaget,DC=Grupp85,DC=ps"
New-GPLink -Name "Password_Policy_Login" -Target "OU=Företaget,DC=Grupp85,DC=ps"
New-GPLink -Name "LOGIN_GPO"             -Target "OU=Företaget,DC=Grupp85,DC=ps"


# ===========================================
# 7) DC03: MAPP STRUKTUR + NTFS, körs mha icacls
# ==========================================

# Skapar mapparna jag ska använda
$folders = @("Anstallda","Ekonomi","Ledning","Forsaljning","Projektgrupp")
foreach ($f in $folders) {
    $path = "E:\Gruppkataloger\$f"
    if (-not (Test-Path $path)) { New-Item $path -ItemType Directory | Out-Null }
}

# Stänger av arv på roten så jag kan styra rättigheter manuellt
icacls "E:\Gruppkataloger" /inheritance:d
# Tar bort standardbehörigheter (Users/Everyone) så att åtkomst styrs enbart via NTFS 
icacls "E:\Gruppkataloger" /remove "Users" "Everyone" 2>$null

# Admin + SYSTEM full (standard)
icacls "E:\Gruppkataloger" /grant "Administrators:(OI)(CI)(F)"
icacls "E:\Gruppkataloger" /grant "SYSTEM:(OI)(CI)(F)"

# Rättigheter per mapp:
# Modify till respektive AD-grupp
# Följt guide: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls
icacls "E:\Gruppkataloger\Ledning"      /inheritance:d
icacls "E:\Gruppkataloger\Ledning"      /grant "GRUPP85\Ledning:(OI)(CI)(M)"

icacls "E:\Gruppkataloger\Ekonomi"      /inheritance:d
icacls "E:\Gruppkataloger\Ekonomi"      /grant "GRUPP85\Ekonomi:(OI)(CI)(M)"

icacls "E:\Gruppkataloger\Forsaljning"  /inheritance:d
icacls "E:\Gruppkataloger\Forsaljning"  /grant "GRUPP85\Forsaljning:(OI)(CI)(M)"

icacls "E:\Gruppkataloger\Projektgrupp" /inheritance:d
icacls "E:\Gruppkataloger\Projektgrupp" /grant "GRUPP85\Projektgrupp:(OI)(CI)(M)"

icacls "E:\Gruppkataloger\Anstallda"    /inheritance:d
icacls "E:\Gruppkataloger\Anstallda"    /grant "GRUPP85\Anstallda:(OI)(CI)(M)"

# Snabbkoll att det ser rimligt ut:
icacls "E:\Gruppkataloger"
icacls "E:\Gruppkataloger\Ekonomi"
icacls "E:\Gruppkataloger\Ledning"


# ============================================================
# 8) DC03: IMPORT users och lägg in i grupper (CSV)
# ==========================================================

$users = Import-Csv "C:\Temp\Users_With_Groups.csv" -Delimiter ';'

# Skapar användare en gång per AccountName
# (CSV har flera rader per user eftersom de kan ha flera grupper)
#Länkar till referenser som använts: 
#https://learn.microsoft.com/en-us/powershell/module/activedirectory/new-aduser?view=windowsserver2025-ps
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.5
$users |
Sort-Object SamAccountName -Unique |
ForEach-Object {
    New-ADUser `
        -Name $_.Name `
        -SamAccountName $_.SamAccountName `
        -UserPrincipalName "$($_.SamAccountName)@Grupp85.ps" `
        -Path "OU=Anställda,OU=Företaget,DC=Grupp85,DC=ps" `
        -AccountPassword (ConvertTo-SecureString "Pa55w0rd" -AsPlainText -Force) `
        -Enabled $true
}

# Lägger till gruppmedlemskap
# (Här är det viktigt att gruppnamnet i CSV faktiskt finns i nya AD:t, så byter alla namn till det korrekta)
$users | ForEach-Object {
    Add-ADGroupMember -Identity $_.Group -Members $_.SamAccountName
}

# (Jag kollade med en user:)
Get-ADUser <sam> -Properties MemberOf | Select -Expand MemberOf



# ==========================================================
# 9) DC03: Test-user "PSTest" baserat på mall
# ============================================================

# Hämtar mall-usern (som redan har grupper)
$template = Get-ADUser "saljarmallv2" -Properties MemberOf

# Skapar PSTest
New-ADUser `
  -Name "PSTest" `
  -SamAccountName "PSTest" `
  -UserPrincipalName "PSTest@Grupp85.ps" `
  -Path "OU=Anställda,OU=Företaget,DC=Grupp85,DC=ps" `
  -AccountPassword (ConvertTo-SecureString "Pa55w0rd" -AsPlainText -Force) `
  -Enabled $true

# Kopierar gruppmedlemskap från mallen
foreach ($g in $template.MemberOf) {
    Add-ADGroupMember -Identity $g -Members "PSTest"
}


# ===============================================================
# 10) KLIENT03: RSAT (så jag kan admina AD/GPO/DNS från klienten)
# ==============================================================
# FÖljt guide: https://www.pdq.com/blog/how-to-install-remote-server-administration-tools-rsat/

# KÖR JAG PÅ KLIENT03

Get-WindowsCapability -Name RSAT* -Online | Select Name, State

Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0
Add-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0

# Kollar att de blev installerade

Get-WindowsCapability -Name RSAT* -Online | Where-Object State -eq Installed

# Här kör jag folder redirect för alla användare och Konfigurera GPO inloggnings och lösenordspolicy via PowerShell.

# Loggar in med min testanvändare och allt fungerar fint!

# ===============================================================
# 11) Analys och reflektioner
# ==============================================================

# Problem som uppstod:
# Vid export/import av användare följde inte alla konton med från början.
# Jag fick flera olika felmeddelanden och vissa användare saknades efter importen.
# Fel uppstod när jag försökte exportera CSV-filen med 'åäö', blev iställer '?' där bokstäverna skulle va
#
# Efter felsökning och justering av scriptet (främst hur CSV-filen hanterades)...
# lyckades jag till slut importera alla användare korrekt och
# automatiskt lägga dem i rätt grupper.

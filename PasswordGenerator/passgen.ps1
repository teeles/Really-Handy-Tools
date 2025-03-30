# Function to generate a secure password of specified length
function Generate-Password {
    param(
        [int]$length
    )
    $password = -join ((48..57) + (65..90) + (97..122) + (33..47) + (58..64) + (91..96) + (123..126) | Get-Random -Count $length | ForEach-Object {[char]$_})
    return $password
}

# Main script
param (
    [switch]$Secure,
    [switch]$SuperSecure,
    [switch]$SuperMegaSecure,
    [switch]$Help
)

if ($Help) {
    Write-Host "Password Generator Help"
    Write-Host "All passwords will have a mix of alphanumeric characters, uppercase and lowercase letters, and symbols."
    Write-Host
    Write-Host "-Secure: Generate a 12-character password."
    Write-Host "-SuperSecure: Generate a 15-character password."
    Write-Host "-SuperMegaSecure: Generate a 30-character password."
    exit
}

if ($Secure) {
    $password = Generate-Password -length 12
    Write-Host $password
} elseif ($SuperSecure) {
    $password = Generate-Password -length 15
    Write-Host $password
} elseif ($SuperMegaSecure) {
    $password = Generate-Password -length 30
    Write-Host $password
} else {
    Write-Host "Unknown option. Use -Help for usage information."
    exit 1
}
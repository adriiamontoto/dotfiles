# Python functions
function Set-PyvenvActive([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    . $venvName/Scripts/Activate.ps1
    python.exe -m pip install --upgrade pip
}

function New-Pyvenv([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    if (Test-Path $venvName) {
        return
    }

    python -m venv $venvName
    Activate-Pyvenv $venvName
    python.exe -m pip install --upgrade pip
}

function Remove-Pyvenv([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    if (-not (Test-Path $venvName)) {
        return
    }

    try {
        deactivate
    }
    catch {
        # If the virtual environment is not active, deactivate will throw an error
    }

    Remove-Item $venvName -Recurse -Force
}

function Install-Requirements([string] $requirementsFile) {
    if ([string]::IsNullOrEmpty($requirementsFile)) {
        $requirementsFile = "requirements.txt"
    }

    pip install -r $requirementsFile
}

function Install-DevRequirements() {
    Install-Requirements "requirements_dev.txt"
}

function Install-Package([string] $packageName) {
    pip install $packageName
}

function Remove-Package([string] $packageName) {
    pip uninstall $packageName
}

function Show-Package([string] $packageName) {
    pip show $packageName
}

function Get-Packages() {
    pip list
}


# Python aliases
Set-Alias -Name py -Value python
Set-Alias -Name python3 -Value python

Set-Alias -Name create -Value New-Pyvenv
Set-Alias -Name activate -Value Set-PyvenvActive
# deactivate is a built-in command in Python
Set-Alias -Name remove -Value Remove-Pyvenv

Set-Alias -Name install -Value Install-DevRequirements
Set-Alias -Name installr -Value Install-Requirements
Set-Alias -Name installd -Value Install-DevRequirements

Set-Alias -Name pipi -Value Install-Package
Set-Alias -Name pipu -Value Remove-Package
Set-Alias -Name pips -Value Show-Package
Set-Alias -Name pipl -Value Get-Packages
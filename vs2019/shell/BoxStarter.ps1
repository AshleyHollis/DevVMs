Update-ExecutionPolicy -Policy RemoteSigned

# Temporary
Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies
choco feature enable -n allowGlobalConfirmation -y

# System configuration
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
Disable-InternetExplorerESC
Disable-BingSearch
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -AlwaysShowIconsOn

# Trust PSGallery
Get-PackageProvider -Name NuGet -ForceBootstrap
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# Workaround for nested chocolatey folders resulting in path too long error
$ChocoCachePath = "C:\Temp"
New-Item -Path $ChocoCachePath -ItemType directory -Force

# Install Nuget Tools
cup nugetpackageexplorer --cacheLocation $ChocoCachePath
cup nuget.commandline --cacheLocation $ChocoCachePath

# Install Remote Connection Tools
cup putty --cacheLocation $ChocoCachePath
cup mremoteng --cacheLocation $ChocoCachePath

#Install SQL Tools
cup sql-server-management-studio --cacheLocation $ChocoCachePath

# Install Troubleshooting Tools
cup wireshark --cacheLocation $ChocoCachePath
cup fiddler --cacheLocation $ChocoCachePath
cup sysinternals --cacheLocation $ChocoCachePath

# Install Browsers
cup googlechrome --cacheLocation $ChocoCachePath
cup firefox --cacheLocation $ChocoCachePath

# Install Visual Studio Code
cup visualstudiocode --cacheLocation $ChocoCachePath

# Install Visual Studio Code Extensions
code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.Go
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.azurecli
code --install-extension ms-azuretools.vscode-azurefunctions
code --install-extension ms-mssql.mssql
code --install-extension ms-python.python
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension mindginative.terraform-snippets
code --install-extension hnw.vscode-auto-open-markdown-preview
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension in4margaret.compareit
code --install-extension waderyan.gitblame
code --install-extension PKief.material-icon-theme
code --install-extension zhuangtongfa.Material-theme
code --install-extension mechatroner.rainbow-csv
code --install-extension mauve.terraform
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension VisualStudioOnlineApplicationInsights.application-insights
code --install-extension humao.rest-client
code --install-extension ryu1kn.annotator
code --install-extension donjayamanne.githistory
code --install-extension eamodio.gitlens
code --install-extension shaharkazaz.git-merger
code --install-extension ipedrazas.kubernetes-snippets
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension blackmist.LinkCheckMD
code --install-extension emilast.LogFileHighlighter
code --install-extension mdickin.markdown-shortcuts
code --install-extension stkb.rewrap
code --install-extension formulahendry.code-runner

cup notepadplusplus --cacheLocation $ChocoCachePath
cup nodejs-lts --cacheLocation $ChocoCachePath
cup python --cacheLocation $ChocoCachePath

cup git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'" --cacheLocation $ChocoCachePath
Install-Module -Force posh-git

cup -y powershell-core --cacheLocation $ChocoCachePath
cup -y pester --cacheLocation $ChocoCachePath

# Common tools
cup TelnetClient -source windowsFeatures --cacheLocation $ChocoCachePath
cup 7zip.install --cacheLocation $ChocoCachePath
cup sysinternals --cacheLocation $ChocoCachePath

# Install Data Transfer tools
cup filezilla --cacheLocation $ChocoCachePath
cup winscp --cacheLocation $ChocoCachePath
cup curl --cacheLocation $ChocoCachePath
cup wget --cacheLocation $ChocoCachePath
cup postman --cacheLocation $ChocoCachePath

# Cloud (Azure) related tools
cup azure-cli --cacheLocation $ChocoCachePath
cup azcopy  --cacheLocation $ChocoCachePath
cup microsoftazurestorageexplorer --cacheLocation $ChocoCachePath

Install-Module -Force Az
Install-Module -Force -Name AzureRM -Scope AllUsers
Install-Module -Force -Name Azure -Scope AllUsers -AllowClobber

cup terraform --cacheLocation $ChocoCachePath

# clean up the cache directory
Remove-Item $ChocoCachePath -Recurse

choco feature disable -n allowGlobalConfirmation -y
Enable-UAC
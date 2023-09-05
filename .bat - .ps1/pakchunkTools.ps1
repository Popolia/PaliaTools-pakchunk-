# URL du manifest
$manifestUrl = "https://update.palia.com/manifest/PatchManifest.json"

# Téléchargez le contenu du manifest depuis l'URL
$manifest = Invoke-RestMethod -Uri $manifestUrl

# Obtenez la dernière version du manifest
$latestVersion = ($manifest.PSObject.Properties.Name | Sort-Object -Descending | Select-Object -First 1)

# Demandez à l'utilisateur de saisir le nom du fichier "pakchunk" (Ask the user to enter the name of the "pakchunk" file)
$selectedPakchunkName = Read-Host "Enter the name of the pakchunk file you wish to download : "

# Obtenez le chemin du dossier du script (Get the path to the script folder)
$scriptFolder = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

# Combinez le dossier du script avec le nom du fichier en utilisant l'encodage UTF-8 (Combine the script folder with the file name using UTF-8 encoding)
$outputFilePath = Join-Path -Path $scriptFolder -ChildPath ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($selectedPakchunkName)))

# Récupérez l'URL du fichier à partir du manifest
$fileInfo = $manifest.$latestVersion.Files | Where-Object { $_.URL -like "*$selectedPakchunkName" }

if ($fileInfo -eq $null) {
    Write-Host "The file '$selectedPakchunkName' was not found in version '$latestVersion' of the manifest."
} else {
    $url = $fileInfo.URL

    # Téléchargez le fichier choisi (Download the selected file)
    Invoke-WebRequest -Uri $url -OutFile $outputFilePath

    # Écrivez un message dans un fichier texte dans le dossier du script (Write a message in a text file in the script folder)
    $message = "The file '$selectedPakchunkName' from version '$latestVersion' has been successfully downloaded at : $outputFilePath"
    $message | Out-File -FilePath "$scriptFolder\download_message.txt" -Encoding UTF8

    # Affichez un message de confirmation dans la console (Display a confirmation message in the console)
    Write-Host "The file '$selectedPakchunkName' from version '$latestVersion' has been successfully downloaded. Please refer to the download_message.txt file in the script folder for more information."
}

# Demandez à l'utilisateur s'il souhaite continuer (Ask the user if they wish to continue)
$continue = Read-Host "Would you like to continue ? (O/N)"

if ($continue -eq "O" -or $continue -eq "o") {
    # L'utilisateur souhaite continuer (The user wishes to continue)
    Write-Host "Continuation..."
} else {
    # L'utilisateur ne souhaite pas continuer, affichez un message et attendez (The user does not wish to continue, display a message and wait)
    Read-Host "Press Enter to exit..."
}

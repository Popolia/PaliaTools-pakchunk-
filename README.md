# PaliaTools (pakchunkTools)

## Exécutables

- **pakchunkTools.EXE** : Télécharge un pakchunk spécifique (ex. `pakchunk2-WindowsClient.pak`) depuis [Palia Manifest](https://update.palia.com/manifest/PatchManifest.json) pour la dernière version.
  
- **Palia_manifeste.EXE** : Crée deux manifests : un pour le hash des fichiers existants et un autre basé sur le manifest de Palia.

- **Logs_Filter_2.exe** : Outil de filtrage pour analyser rapidement les manifests.

### Remarques

- Le fichier `.bat` est conservé pour les cas d'utilisation, mais n'est généralement pas nécessaire.
- Pour la **Vérification de l'intégrité des fichiers**, comparez les valeurs de hash (MD5, SHA-1, SHA-256) des fichiers originaux avec ceux actuels.

## Fonctionnalités de Logs_Filter_2

- Recherche efficace dans les journaux, plus rapide que `ctrl+f`.
- Filtrage basé sur une ou plusieurs conditions.
- Sensibilité à la casse : option pour activer/désactiver.
- Statistiques en temps réel : nombre de lignes recherchées et correspondant aux filtres.
- Copier les résultats dans le presse-papiers d'un clic.
- Préférences sauvegardées pour la taille, le style et la couleur de la police.
- Glisser-déposer pour charger les fichiers journaux facilement.

## Chemin de fichier par défaut

- `C:\Users\Admin\AppData\Local\Palia\Client\Palia\Content\Paks`
- Accès à AppData : `Windows + R` puis `%localappdata%`.

## Script PowerShell pour Télécharger un Pakchunk

### Description

Ce script télécharge un fichier pakchunk à partir du manifest de Palia.

### Code du Script

```powershell
# URL du manifest
$manifestUrl = "https://update.palia.com/manifest/PatchManifest.json"

# Téléchargez le contenu du manifest depuis l'URL
try {
    $manifest = Invoke-RestMethod -Uri $manifestUrl
} catch {
    Write-Host "Erreur lors du téléchargement du manifest : $_"
    exit
}

# Obtenez la dernière version du manifest
$latestVersion = ($manifest.PSObject.Properties.Name | Sort-Object -Descending | Select-Object -First 1)

# Demandez à l'utilisateur de saisir le nom du fichier "pakchunk"
$selectedPakchunkName = Read-Host "Enter the name of the pakchunk file you wish to download : "

if (-not $selectedPakchunkName) {
    Write-Host "Le nom du fichier ne peut pas être vide."
    exit
}

# Obtenez le chemin du dossier du script
$scriptFolder = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

# Combinez le dossier du script avec le nom du fichier
$outputFilePath = Join-Path -Path $scriptFolder -ChildPath ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($selectedPakchunkName)))

# Récupérez l'URL du fichier à partir du manifest
$fileInfo = $manifest.$latestVersion.Files | Where-Object { $_.URL -like "*$selectedPakchunkName" }

if ($fileInfo -eq $null) {
    Write-Host "Le fichier '$selectedPakchunkName' n'a pas été trouvé dans la version '$latestVersion' du manifest."
} else {
    $url = $fileInfo.URL

    # Téléchargez le fichier choisi
    try {
        Invoke-WebRequest -Uri $url -OutFile $outputFilePath
    } catch {
        Write-Host "Erreur lors du téléchargement du fichier : $_"
        exit
    }

    # Écrivez un message dans un fichier texte dans le dossier du script
    $message = "The file '$selectedPakchunkName' from version '$latestVersion' has been successfully downloaded at : $outputFilePath"
    $message | Out-File -FilePath "$scriptFolder\download_message.txt" -Encoding UTF8

    # Affichez un message de confirmation dans la console
    Write-Host "Le fichier '$selectedPakchunkName' de la version '$latestVersion' a été téléchargé avec succès. Veuillez consulter le fichier download_message.txt dans le dossier du script pour plus d'informations."
}

# Demandez à l'utilisateur s'il souhaite continuer
$continue = Read-Host "Would you like to continue ? (O/N)"

if ($continue -eq "O" -or $continue -eq "o") {
    Write-Host "Continuation..."
} else {
    Read-Host "Press Enter to exit..."
}

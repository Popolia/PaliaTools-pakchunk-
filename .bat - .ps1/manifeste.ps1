# Spécifiez le chemin du répertoire que vous souhaitez explorer
$cheminDuRepertoire = "C:\Users\Admin\AppData\Local\Palia\Client\Palia\Content\Paks"

# Obtenez la liste des fichiers dans le répertoire (et ses sous-répertoires) avec leurs chemins complets
$manifeste = Get-ChildItem -Path $cheminDuRepertoire -File -Recurse | Select-Object FullName

# Spécifiez le chemin d'accès où vous souhaitez enregistrer le fichier CSV du manifeste
$cheminManifeste = "C:\Users\Admin\Downloads\manifeste_paks.csv"

# Exportez la liste des fichiers dans un fichier CSV
$manifeste | Export-Csv -Path $cheminManifeste -NoTypeInformation

# Affichez un message indiquant que le manifeste a été créé avec succès et enregistré dans le chemin spécifié
Write-Host "Manifeste des fichiers du répertoire créé avec succès et enregistré dans : $cheminManifeste"

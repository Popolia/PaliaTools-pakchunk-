# Spécifiez le chemin du répertoire que vous souhaitez explorer
$cheminDuRepertoire = "C:\Users\Admin\AppData\Local\Palia\Client\Palia\Content\Paks"

# Spécifiez le chemin du fichier où vous souhaitez enregistrer le manifeste
$cheminDuManifeste = "C:\Users\Admin\Downloads\manifeste_paks.csv"

# Obtenir la liste des fichiers dans le répertoire
$listeFichiers = Get-ChildItem -Path $cheminDuRepertoire -File

# Créer un tableau pour stocker les informations de hachage
$manifeste = @()

# Parcourir la liste des fichiers
foreach ($fichier in $listeFichiers) {
    # Calculer le hachage SHA-256 du fichier
    $hachageSHA256 = (Get-FileHash -Path $fichier.FullName -Algorithm SHA256).Hash

    # Créer un objet contenant le nom du fichier et son hachage SHA-256
    $objetFichier = New-Object PSObject -Property @{
        "Nom du Fichier" = $fichier.Name
        "Hachage SHA-256" = $hachageSHA256
    }

    # Ajouter l'objet au manifeste
    $manifeste += $objetFichier
}

# Exporter le manifeste au format CSV
$manifeste | Export-Csv -Path $cheminDuManifeste -NoTypeInformation

# Afficher un message de confirmation
Write-Host "Manifeste des hachages SHA-256 créé avec succès et enregistré dans : $cheminDuManifeste"

Write-Host "Please wait while the manifests are created ^_^"
# Obtenir le nom d'utilisateur actuel
$nomUtilisateur = $env:USERNAME

# Spécifier le chemin du répertoire en utilisant le nom d'utilisateur
$cheminDuRepertoire = "C:\Users\$nomUtilisateur\AppData\Local\Palia\Client\Palia\Content\Paks"

# Spécifier le chemin du fichier où vous souhaitez enregistrer le manifeste SHA-256
$cheminDuManifesteSHA256 = "C:\Users\$nomUtilisateur\Downloads\manifeste_paks_sha256.csv"

# Obtenir la liste des fichiers dans le répertoire
$listeFichiers = Get-ChildItem -Path $cheminDuRepertoire -File

# Créer un tableau pour stocker les informations de hachage SHA-256
$manifesteSHA256 = @()

# Parcourir la liste des fichiers
foreach ($fichier in $listeFichiers) {
    # Calculer le hachage SHA-256 du fichier
    $hachageSHA256 = (Get-FileHash -Path $fichier.FullName -Algorithm SHA256).Hash

    # Créer un objet contenant le nom du fichier et son hachage SHA-256
    $objetFichier = New-Object PSObject -Property @{
        "Nom du Fichier" = $fichier.Name
        "Hachage SHA-256" = $hachageSHA256
    }

    # Ajouter l'objet au manifeste SHA-256
    $manifesteSHA256 += $objetFichier
}

# Exporter le manifeste SHA-256 au format CSV
$manifesteSHA256 | Export-Csv -Path $cheminDuManifesteSHA256 -NoTypeInformation

# Afficher un message indiquant que le manifeste SHA-256 a été créé avec succès
Write-Host "Manifeste des hachages SHA-256 créé avec succès et enregistré dans : $cheminDuManifesteSHA256"

# Spécifiez le chemin d'accès où vous souhaitez enregistrer le manifeste de référence
$cheminManifesteDeReference = "C:\Users\Admin\Downloads\manifeste_de_reference.txt"

# Créez un manifeste de référence en tant qu'URL
$manifesteDeReferenceURL = "https://update.palia.com/manifest/PatchManifest.json"

# Téléchargez le manifeste de référence et enregistrez-le localement
Invoke-WebRequest -Uri $manifesteDeReferenceURL -OutFile $cheminManifesteDeReference

# Affichez un message indiquant que le manifeste de référence a été téléchargé avec succès
Write-Host "Manifeste de référence téléchargé avec succès depuis : $manifesteDeReferenceURL et enregistré dans : $cheminManifesteDeReference"

@echo off

REM Spécifiez le chemin vers le script PowerShell (Specify the path to the PowerShell script)
set ps1_script=TelechargerFichier.ps1

REM Exécutez le script PowerShell (Run the PowerShell script)
powershell.exe -ExecutionPolicy Bypass -File "%ps1_script%"

REM Sortie du script batch (Batch script output)
exit

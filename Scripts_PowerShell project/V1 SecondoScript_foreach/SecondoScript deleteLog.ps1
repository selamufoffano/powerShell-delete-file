# Selamu Foffano 07/09/2023 
# Script finalizzato a eliminare i log ricorsivamente da una cartella
########################################################################################
Write-Host "############################# DELETE LOG ################################`n"

# parameters
$path = "c:\path"
$retention = 10 # Numero di giorni oltre al quale verranno cancellati

# Ottiene la data corrente
$currentTime = Get-Date

# Verifica se la differenza è maggiore del periodo indicato da retantion
foreach ($file in (Get-ChildItem -Path $path)) {
    $gapDays = ($currentTime - $file.LastWriteTime).Days
    if ($gapDays -gt $retention) {
        Remove-Item -Path $file.FullName -Force
        Write-Host "Il file $file.Name è stato eliminato perché è più vecchio di $retention giorni."
    } else {
        continue
        Write-Host "Il file $file.Name non è stato eliminato perché non supera i $retention giorni."
    }
}
Write-Host "`nScript eseguita con successo"
# Selamu Foffano 07/09/2023 
# Script finalizzato a eliminare i log ricorsivamente da una cartella
########################################################################################
Write-Host "############################# DELETE LOG ################################"

# parameters
$path = "c:\path"
$retention = 180
# Ottiene la data corrente
$currentTime = Get-Date

# counter
$counter = ((Get-ChildItem -Path $path).Length)-1
if ($counter -le 1){
    break
}

Write-Host $lunghezza

# Verifica se la differenza è maggiore del periodo di conservazione
for ($var = 0; $var -le $counter; $var++) {
    $fileDaRimuovere = Get-ChildItem -Path $path | Sort-Object LastWriteTime | Select-Object -First 1
    # Ottiene la data dell'ultima volta che è stato fatta una modifica
    $lasTimeModify = (Get-ChildItem -Path $path | Sort-Object LastWriteTime | Select-Object -First 1).LastWriteTime
    # Calcola la differenza di giorni tra la data corrente e la data dell'ultima modifica
    $gapDays = ($currentTime - $lasTimeModify).Days   
    if ($gapDays -gt $retention) {
        # Elimina il file
        Remove-Item -Path $fileDaRimuovere.FullName -Force
        #Write-Host "Il file è stato eliminato perché è più vecchio di $retention giorni."
    } else {
        #Write-Host "Nessun file è stato eliminato perché nessun file supera i $retention giorni."
    }
}
Write-Host "`nScript eseguita con successo"
###### TEST - per modificare la data di un certo file
#(Get-Item "c:\path").CreationTime=("3 August 2019 17:00:00")

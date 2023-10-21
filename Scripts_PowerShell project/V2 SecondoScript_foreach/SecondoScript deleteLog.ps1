# Selamu Foffano 07/09/2023 
# Script finalizzato a eliminare i log ricorsivamente da una cartella
########################################################################################
Write-Host "############################# DELETE LOG ################################`n"

# percorso lista csv
$csvPath = "C:\Users\foffa\Downloads\PowerShell project\SaveSecondo foreach V2\pathlist.csv"
$csvContent = Import-Csv -Path $csvPath

# Per memorizzare i valori dei parametri del csv
$pathList = @() # array path
$retention = @() # array per il numero di giorni oltre al quale verranno cancellati
$boolean = @() # array boolean, lettura delle sotto cartelle

foreach ($row in $csvContent) {
    $pathList += $row.path
    $retention += $row.retention
    $boolean += $row.boolean
}
Write-Host $pathList
Write-Host $retention
Write-Host $boolean


# Questa sezione può essere utilizzata per 
# inserire il percorso del file CSV 
# contenete tutti i parametri come:
# - il percorso dove sono i vari log 
# - n° retention 
# - boolean (per i file delle sotto cartelle) 

#RICAVARE LE VARIE CARTELLE 
#$printList = (Get-ChildItem -Path $pathCSV).Name
#Write-Host ($printList | Format-Table | Out-String) #Le cartelle non avranno le estensioni




##############
$path = "C:\Users\foffa\Downloads\PowerShell project\SaveSecondo foreach V2\Log\"       
$retention = 180 # Numero di giorni oltre al quale verranno cancellati

# Verifica se la differenza è maggiore del periodo indicato da retantion
foreach ($file in (Get-ChildItem -Path $path | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$retention)})) {
    Remove-Item -Path $file.FullName -Force
    Write-Host "Il file $($file) è stato eliminato perché è più vecchio di $retention giorni."
}
Write-Host "`nScript eseguita con successo"
###### TEST - per modificare la data di un certo file
#(Get-Item "C:\Users\sfoffa\Desktop\SaveSecondo\Log\log - Copia (2).txt").LastWriteTime=("3 August 2019 17:00:00")

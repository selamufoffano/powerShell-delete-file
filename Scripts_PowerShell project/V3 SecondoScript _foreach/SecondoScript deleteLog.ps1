# Selamu Foffano 07/09/2023 
# Script finalizzato a eliminare i log ricorsivamente da una cartella
# E' possibile testare lo script usando -Whatif.
# - Prima di eseguire il codice modificare il percorso del file CSV. Es: "C:\users\user\pathlist.csv"
# Usare -Whatif solo in fase di test. 
Write-Output "############################# DELETE LOG ################################`n"
$csvContent = Get-Content "C:\users\user\pathlist.csv" | Where-Object { $_ -notlike "#*" } | ConvertFrom-Csv # file CSV filtrato senza commenti
foreach ($row in $csvContent) {
    if(Test-Path -Path $row.path){ # Verifica se il percorso esiste. La condizione è true
        if($row.recurse){ # Condizione se è solo vero
            foreach ($file in (Get-ChildItem -Recurse -File -Path $row.path | Where-Object {$_.extension -in $row.filter} | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$row.retention)})) {
                Remove-Item -Path $file.FullName -Force #-Whatif # (Solo in fase di test usare "-whatif")
                Write-Output "Il file $($file) è stato eliminato perché è più vecchio di" $row.retention "giorni."
            }
        }else{ # Condizione se è solo falso
            foreach ($file in (Get-ChildItem -File -Path $row.path | Where-Object {$_.extension -in $row.filter}| Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$row.retention)})) {
                Remove-Item -Path $file.FullName -Force #-Whatif # (Solo in fase di test usare "-whatif")
                Write-Output "Il file $($file) è stato eliminato perché è più vecchio di giorni."
            }
        }
    }else{# Nel caso in cui il percorso non esista. La condizione è false
        Write-Output "ERROR:" $row.path "percorso non valido"
    }
}
Write-Output "`nScript terminato"
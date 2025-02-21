$destinationDir = "packages"

# Create the destination directory if it doesn't exist
if (-not (Test-Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir
}

# Compress each subdirectory into a ZIP file
Get-ChildItem -Directory | ForEach-Object {
    if ($_.Name -eq $destinationDir -or $_.Name -eq "__pycache__" -or $_.Name -eq ".git" -or $_.Name -eq ".vscode") {
        return
    }
    $folderName = $_.Name
    $zipFileName = "$destinationDir\$folderName.zip"
    Compress-Archive -Path (Join-Path $_.FullName "*") -DestinationPath $zipFileName -Force -CompressionLevel Optimal
    Compress-Archive -Path ".\.vscode" -DestinationPath $zipFileName -Update -CompressionLevel Optimal
    Write-Host "Created: $zipFileName"

}
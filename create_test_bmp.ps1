# Test BMP dosyası oluşturucu
param([string]$OutputFile = "test.bmp")

function Create-TestBmp {
    param([string]$FileName)
    
    # BMP parametreleri
    $width = 10
    $height = 10
    $bitsPerPixel = 24
    $rowSize = [math]::Ceiling(($width * $bitsPerPixel) / 32) * 4
    $imageSize = $rowSize * $height
    $fileSize = 54 + $imageSize
    
    # BMP byte array oluştur
    $bmpData = New-Object byte[] $fileSize
    
    # BMP header
    $bmpData[0] = 0x42; $bmpData[1] = 0x4D  # "BM"
    
    # File size
    $bytes = [BitConverter]::GetBytes([uint32]$fileSize)
    [Array]::Copy($bytes, 0, $bmpData, 2, 4)
    
    # Data offset
    $bmpData[10] = 54; $bmpData[11] = 0; $bmpData[12] = 0; $bmpData[13] = 0
    
    # DIB header size
    $bmpData[14] = 40; $bmpData[15] = 0; $bmpData[16] = 0; $bmpData[17] = 0
    
    # Width ve Height
    $bytes = [BitConverter]::GetBytes([uint32]$width)
    [Array]::Copy($bytes, 0, $bmpData, 18, 4)
    $bytes = [BitConverter]::GetBytes([uint32]$height)
    [Array]::Copy($bytes, 0, $bmpData, 22, 4)
    
    # Planes ve bits per pixel
    $bmpData[26] = 1; $bmpData[27] = 0
    $bmpData[28] = $bitsPerPixel; $bmpData[29] = 0
    
    # Pixel data (renkli pattern)
    $dataOffset = 54
    for ($y = 0; $y -lt $height; $y++) {
        for ($x = 0; $x -lt $width; $x++) {
            $pixelIndex = $dataOffset + ($y * $rowSize) + ($x * 3)
            $bmpData[$pixelIndex] = [byte](($x * 25) % 256)
            $bmpData[$pixelIndex + 1] = [byte](($y * 25) % 256)
            $bmpData[$pixelIndex + 2] = [byte]((($x + $y) * 12) % 256)
        }
    }
    
    # Dosyayı kaydet
    [System.IO.File]::WriteAllBytes($FileName, $bmpData)
    Write-Host "Test BMP dosyası oluşturuldu: $FileName" -ForegroundColor Green
}

Write-Host "Test BMP Oluşturucu" -ForegroundColor Cyan
Create-TestBmp $OutputFile 
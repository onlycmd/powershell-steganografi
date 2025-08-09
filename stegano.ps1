# =============================================================================
# STEGANOGRAFI ARACI - PowerShell
# Görsellerin içine gizli mesaj saklama ve çıkarma
# =============================================================================

param(
    [string]$Action = "",
    [string]$ImageFile = "",
    [string]$Message = "",
    [string]$OutputFile = ""
)

function Show-Help {
    Write-Host "STEGANOGRAFI ARACI - PowerShell" -ForegroundColor Cyan
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "KULLANIM:" -ForegroundColor Yellow
    Write-Host "  .\stegano.ps1 -Action hide -ImageFile resim.bmp -Message 'gizli mesaj' -OutputFile output.bmp"
    Write-Host "  .\stegano.ps1 -Action extract -ImageFile output.bmp"
    Write-Host ""
}

function Hide-Message {
    param([string]$ImagePath, [string]$Message, [string]$OutputPath)
    
    Write-Host "Mesaj gizleniyor..." -ForegroundColor Green
    
    if (-not (Test-Path $ImagePath)) {
        Write-Host "Hata: Dosya bulunamadi: $ImagePath" -ForegroundColor Red
        return
    }
    
    $imageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
    Write-Host "Dosya okundu: $($imageBytes.Length) byte" -ForegroundColor Gray
    
    # Mesaji binary'ye cevir
    $binary = ""
    for ($i = 0; $i -lt $Message.Length; $i++) {
        $ascii = [byte][char]$Message[$i]
        $bin = [Convert]::ToString($ascii, 2).PadLeft(8, '0')
        $binary += $bin
    }
    $binary += "00000000"  # Mesaj sonu
    
    Write-Host "Binary uzunluk: $($binary.Length) bit" -ForegroundColor Gray
    
    # LSB steganografi
    $dataStart = 54
    for ($i = 0; $i -lt $binary.Length; $i++) {
        $byteIndex = $dataStart + $i
        if ($byteIndex -lt $imageBytes.Length) {
            $bit = [int]$binary[$i].ToString()
            $imageBytes[$byteIndex] = ($imageBytes[$byteIndex] -band 254) -bor $bit
        }
    }
    
    [System.IO.File]::WriteAllBytes($OutputPath, $imageBytes)
    Write-Host "Mesaj gizlendi: $OutputPath" -ForegroundColor Green
}

function Extract-Message {
    param([string]$ImagePath)
    
    Write-Host "Mesaj cikariliyor..." -ForegroundColor Green
    
    if (-not (Test-Path $ImagePath)) {
        Write-Host "Hata: Dosya bulunamadi: $ImagePath" -ForegroundColor Red
        return
    }
    
    $imageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
    Write-Host "Dosya okundu: $($imageBytes.Length) byte" -ForegroundColor Gray
    
    $binary = ""
    $dataStart = 54
    
    for ($i = $dataStart; $i -lt $imageBytes.Length; $i++) {
        $lsb = $imageBytes[$i] -band 1
        $binary += $lsb.ToString()
        
        if ($binary.Length % 8 -eq 0 -and $binary.Length -ge 8) {
            $lastByte = $binary.Substring($binary.Length - 8, 8)
            if ($lastByte -eq "00000000") {
                $binary = $binary.Substring(0, $binary.Length - 8)
                break
            }
        }
    }
    
    # Binary'yi metne cevir
    $text = ""
    for ($i = 0; $i -lt $binary.Length; $i += 8) {
        if ($i + 7 -lt $binary.Length) {
            $byte = $binary.Substring($i, 8)
            $ascii = [Convert]::ToInt32($byte, 2)
            $text += [char]$ascii
        }
    }
    
    if ($text.Length -gt 0) {
        Write-Host "Bulunan mesaj: '$text'" -ForegroundColor Yellow
    } else {
        Write-Host "Gizli mesaj bulunamadi" -ForegroundColor Yellow
    }
}

# Ana program
if ($Action -eq "") {
    Show-Help
} elseif ($Action -eq "hide") {
    if ($ImageFile -eq "" -or $Message -eq "" -or $OutputFile -eq "") {
        Write-Host "Hata: Eksik parametre" -ForegroundColor Red
        Show-Help
    } else {
        Hide-Message $ImageFile $Message $OutputFile
    }
} elseif ($Action -eq "extract") {
    if ($ImageFile -eq "") {
        Write-Host "Hata: ImageFile gerekli" -ForegroundColor Red
        Show-Help
    } else {
        Extract-Message $ImageFile
    }
} else {
    Write-Host "Hata: Gecersiz action: $Action" -ForegroundColor Red
    Show-Help
} 
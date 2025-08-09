Write-Host "Steganografi Test Scripti" -ForegroundColor Green
Write-Host "========================" -ForegroundColor Green
Write-Host ""

# Test 1: Mesaj gizle
Write-Host "Test 1: Mesaj gizleniyor..." -ForegroundColor Yellow
& .\\stegano.ps1 -Action hide -ImageFile sample.bmp -Message "Gizli Test Mesaji" -OutputFile output.bmp

Write-Host ""

# Test 2: Mesaj cikart
Write-Host "Test 2: Mesaj cikariliyor..." -ForegroundColor Yellow
& .\\stegano.ps1 -Action extract -ImageFile output.bmp

Write-Host ""
Write-Host "Test tamamlandi!" -ForegroundColor Green 
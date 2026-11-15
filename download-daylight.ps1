$imgDir = "C:\Users\omar.walid\.gemini\antigravity\scratch\tatweer-misr-landing\assets\images"

$images = @{
    "hero-daylight.jpg" = "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1800&q=85";
    "bloomfields-daylight.jpg" = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1400&q=85";
    "galala-cliff-sea.jpg" = "https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?auto=format&fit=crop&w=1400&q=85";
    "rivers-daylight.jpg" = "https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&w=1400&q=85"
}

foreach ($item in $images.GetEnumerator()) {
    $target = Join-Path $imgDir $item.Key
    Write-Host "Downloading $($item.Key)..."
    Invoke-WebRequest -Uri $item.Value -OutFile $target -UserAgent "Mozilla/5.0"
}

Get-ChildItem $imgDir | Select-Object Name, Length

$code = @'
using System;
using System.Drawing;
using System.Drawing.Imaging;

public class LogoProcessor {
    public static void MakeTransparentDark(string inputPath, string outputPath, bool preserveColors) {
        using (Bitmap src = new Bitmap(inputPath)) {
            Bitmap dst = new Bitmap(src.Width, src.Height, PixelFormat.Format32bppArgb);
            for (int y = 0; y < src.Height; y++) {
                for (int x = 0; x < src.Width; x++) {
                    Color c = src.GetPixel(x, y);
                    int brightness = (int)(0.299 * c.R + 0.587 * c.G + 0.114 * c.B);
                    if (brightness < 35 && (!preserveColors || (c.R < 70 && c.G < 70 && c.B < 70))) {
                        dst.SetPixel(x, y, Color.FromArgb(0, 0, 0, 0));
                    } else if (preserveColors && (c.R > 130 && c.R > c.G + 35 && c.R > c.B + 35)) {
                        dst.SetPixel(x, y, Color.FromArgb(255, c.R, c.G, c.B));
                    } else {
                        int alpha = Math.Min(255, (int)(brightness * 1.3));
                        dst.SetPixel(x, y, Color.FromArgb(alpha, 20, 24, 33)); // Luxury deep dark slate
                    }
                }
            }
            dst.Save(outputPath, ImageFormat.Png);
        }
    }
}
'@

Add-Type -TypeDefinition $code -ReferencedAssemblies System.Drawing

$srcDir = "C:\Users\omar.walid\.gemini\antigravity\scratch\tatweer-misr-landing\assets\logos"
$outDir = "C:\Users\omar.walid\.gemini\antigravity\scratch\tatweer-misr-landing\assets\logos-transparent"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

[LogoProcessor]::MakeTransparentDark("$srcDir\tatweer-misr-logo.webp", "$outDir\tatweer-misr-dark.png", $true)
[LogoProcessor]::MakeTransparentDark("$srcDir\bloomfields-logo.png", "$outDir\bloomfields-dark.png", $false)
[LogoProcessor]::MakeTransparentDark("$srcDir\il-monte-galala-logo.png", "$outDir\il-monte-galala-dark.png", $false)
[LogoProcessor]::MakeTransparentDark("$srcDir\rivers-logo.jpg", "$outDir\rivers-dark.png", $false)
[LogoProcessor]::MakeTransparentDark("$srcDir\scenes-logo.png", "$outDir\scenes-dark.png", $false)

Write-Host "All logos processed to transparent PNGs with dark typography!"
Get-ChildItem $outDir | Select-Object Name, Length

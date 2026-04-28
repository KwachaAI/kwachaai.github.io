$filePath = 'index.html'
$content = Get-Content $filePath -Raw -Encoding UTF8

# New head block to inject — replaces everything from <!-- Primary Meta Tags --> through <!-- Favicon -->
$oldBlock = @'
  <!-- Primary Meta Tags -->
'@

# We'll inject canonical, keywords, author, robots right after the description line
# and before the OG block, then upgrade OG/Twitter, add JSON-LD

# 1. Replace the title
$content = $content -replace '<title>[^<]+</title>', '<title>KwachaAI - Free AI Desktop App for Work, Study and Code | Official Site</title>'

# 2. Replace meta name="title"
$content = $content -replace 'content="KwachaAI [^"]+ Code"', 'content="KwachaAI - Free AI Desktop App for Work, Study and Code | Official Site"'

# 3. Replace the meta description (single-line style that might span lines)
$oldDesc = '  <meta name="description"
    content="KwachaAI is a free AI-powered desktop app that helps you work, study, and code — all in one workspace. Powered by the world' + "'" + 's leading AI models. Made in Zambia." />'
$newDesc = '  <meta name="description" content="KwachaAI is the original free AI-powered desktop app for Windows. Work, study, and code with GPT-4o, Claude, Gemini and more - all in one place. No cloud lock-in. No account needed. Made in Zambia." />' + "`r`n" +
'  <meta name="keywords" content="KwachaAI, Kwacha AI, AI desktop app, free AI workspace, AI coding assistant, AI study tool, AI for work, GPT-4o desktop, Claude desktop, Gemini desktop, AI app Zambia, AI app Africa, code mode AI, multi-model AI, free AI tool Windows" />' + "`r`n" +
'  <meta name="author" content="KwachaAI - Original, Made in Zambia" />' + "`r`n" +
'  <meta name="robots" content="index, follow" />' + "`r`n" +
'  <link rel="canonical" href="https://kwachaai.github.io/" />'
$content = $content.Replace($oldDesc, $newDesc)

# 4. Replace OG block
$oldOG = '  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website" />
  <meta property="og:url" content="https://kwachaai.github.io/" />
  <meta property="og:title" content="KwachaAI — Your AI Desktop Workspace" />
  <meta property="og:description"
    content="Free AI-powered desktop app for work, study &amp; code. Powered by the world' + "'" + 's best AI models. Made in Zambia." />
  <meta property="og:image" content="https://kwachaai.github.io/assets/hero1.png" />'
$newOG = '  <!-- Open Graph / Facebook / LinkedIn -->
  <meta property="og:type" content="website" />
  <meta property="og:url" content="https://kwachaai.github.io/" />
  <meta property="og:site_name" content="KwachaAI" />
  <meta property="og:locale" content="en_US" />
  <meta property="og:title" content="KwachaAI - The Original Free AI Desktop Workspace" />
  <meta property="og:description" content="The original AI-powered desktop app for work, study and code. Use GPT-4o, Claude, Gemini and more - all in one place. Free. No account needed. Made in Zambia." />
  <meta property="og:image" content="https://kwachaai.github.io/assets/hero1.png" />
  <meta property="og:image:width" content="1280" />
  <meta property="og:image:height" content="800" />
  <meta property="og:image:alt" content="KwachaAI Code Mode - AI-powered file explorer, editor and terminal on Windows" />'
$content = $content.Replace($oldOG, $newOG)

# 5. Replace Twitter block + add JSON-LD
$oldTw = '  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image" />
  <meta property="twitter:url" content="https://kwachaai.github.io/" />
  <meta property="twitter:title" content="KwachaAI — Your AI Desktop Workspace" />
  <meta property="twitter:description"
    content="Free AI-powered desktop app for work, study &amp; code. Powered by the world' + "'" + 's best AI models. Made in Zambia." />
  <meta property="twitter:image" content="https://kwachaai.github.io/assets/hero1.png" />'
$newTw = '  <!-- Twitter / X Card -->
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:url" content="https://kwachaai.github.io/" />
  <meta name="twitter:site" content="@kwachaai" />
  <meta name="twitter:creator" content="@kwachaai" />
  <meta name="twitter:title" content="KwachaAI - The Original Free AI Desktop Workspace" />
  <meta name="twitter:description" content="The original AI-powered desktop app for work, study and code. Use GPT-4o, Claude, Gemini and more. Free. Made in Zambia." />
  <meta name="twitter:image" content="https://kwachaai.github.io/assets/hero1.png" />
  <meta name="twitter:image:alt" content="KwachaAI Code Mode - AI-powered file explorer, editor and terminal on Windows" />

  <!-- Structured Data - SoftwareApplication (JSON-LD) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    "name": "KwachaAI",
    "alternateName": "Kwacha AI",
    "url": "https://kwachaai.github.io/",
    "description": "KwachaAI is the original free AI-powered desktop app for Windows. Get a unified workspace for work, study, and code powered by GPT-4o, Claude, Gemini and more. No account required. Made in Zambia.",
    "applicationCategory": "ProductivityApplication",
    "applicationSubCategory": "AI Assistant",
    "operatingSystem": "Windows 10, Windows 11",
    "softwareVersion": "Public Preview",
    "image": "https://kwachaai.github.io/assets/hero1.png",
    "screenshot": [
      "https://kwachaai.github.io/assets/hero1.png",
      "https://kwachaai.github.io/assets/hero2.png",
      "https://kwachaai.github.io/assets/hero3.png"
    ],
    "offers": {
      "@type": "Offer",
      "price": "0",
      "priceCurrency": "USD",
      "availability": "https://schema.org/InStock"
    },
    "author": {
      "@type": "Organization",
      "name": "KwachaAI",
      "url": "https://kwachaai.github.io/",
      "foundingLocation": "Zambia"
    }
  }
  </script>'
$content = $content.Replace($oldTw, $newTw)

# Write back
[System.IO.File]::WriteAllText((Resolve-Path $filePath), $content, [System.Text.Encoding]::UTF8)
Write-Host "Done. File written successfully."

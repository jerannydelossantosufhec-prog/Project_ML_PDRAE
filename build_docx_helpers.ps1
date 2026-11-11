Add-Type -AssemblyName System.IO.Compression.FileSystem

$buildDir = "c:\Users\d20a7625\Downloads\Project_ML\docx_build"
$xmlPath = "$buildDir\word\document.xml"

$xmlDoc = New-Object System.Xml.XmlDocument
$xmlDoc.PreserveWhitespace = $true
$xmlDoc.Load($xmlPath)

$ns = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")

$wNs = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"

# Helper to create a paragraph with runs
function New-WParagraph {
    param($doc, $paraData) # paraData: array of hashtables @{ Text = "..."; Bold = $true/$false; Italic = $false; Color = "..." }
    $p = $doc.CreateElement("w", "p", $wNs)
    
    # If paraData is just a string, convert to array
    if ($paraData -is [string]) {
        $paraData = @(@{ Text = $paraData; Bold = $false })
    }
    
    foreach ($runData in $paraData) {
        $r = $doc.CreateElement("w", "r", $wNs)
        
        $hasProps = $runData.Bold -or $runData.Italic -or $runData.Color -or $runData.Size
        if ($hasProps) {
            $rPr = $doc.CreateElement("w", "rPr", $wNs)
            if ($runData.Bold) {
                [void]$rPr.AppendChild($doc.CreateElement("w", "b", $wNs))
            }
            if ($runData.Italic) {
                [void]$rPr.AppendChild($doc.CreateElement("w", "i", $wNs))
            }
            if ($runData.Color) {
                $c = $doc.CreateElement("w", "color", $wNs)
                $c.SetAttribute("val", $wNs, $runData.Color)
                [void]$rPr.AppendChild($c)
            }
            if ($runData.Size) {
                $sz = $doc.CreateElement("w", "sz", $wNs)
                $sz.SetAttribute("val", $wNs, $runData.Size)
                [void]$rPr.AppendChild($sz)
            }
            [void]$r.AppendChild($rPr)
        }
        
        $t = $doc.CreateElement("w", "t", $wNs)
        if ($runData.Text -match '^\s|\s$') {
            $t.SetAttribute("space", "http://www.w3.org/XML/1998/namespace", "preserve")
        }
        $t.InnerText = $runData.Text
        [void]$r.AppendChild($t)
        [void]$p.AppendChild($r)
    }
    return $p
}

# Helper to replace cell content with an array of paragraph specifications
function Update-CellContent {
    param($cell, $paragraphs)
    # Preserve w:tcPr
    $tcPr = $cell.SelectSingleNode("w:tcPr", $ns)
    
    # Remove all child nodes
    $children = @()
    foreach ($node in $cell.ChildNodes) { $children += $node }
    foreach ($node in $children) { [void]$cell.RemoveChild($node) }
    
    # Re-add tcPr if existed
    if ($tcPr) {
        [void]$cell.AppendChild($tcPr)
    }
    
    # Add new paragraphs
    foreach ($pSpec in $paragraphs) {
        $p = New-WParagraph $cell.OwnerDocument $pSpec
        [void]$cell.AppendChild($p)
    }
}

function Set-ParaText {
    param($para, $text, $ns, $bold = $false)
    $runs = $para.SelectNodes("w:r", $ns)
    foreach ($r in $runs) { [void]$para.RemoveChild($r) }
    
    $newR = $para.OwnerDocument.CreateElement("w", "r", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
    if ($bold) {
        $rPr = $para.OwnerDocument.CreateElement("w", "rPr", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
        $b = $para.OwnerDocument.CreateElement("w", "b", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
        [void]$rPr.AppendChild($b)
        [void]$newR.AppendChild($rPr)
    }
    $newT = $para.OwnerDocument.CreateElement("w", "t", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
    $newT.InnerText = $text
    [void]$newR.AppendChild($newT)
    [void]$para.AppendChild($newR)
}

Write-Output "Functions loaded successfully."

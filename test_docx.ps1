Add-Type -AssemblyName System.IO.Compression.FileSystem

$docxPath = "c:\Users\d20a7625\Downloads\Project_ML\Proyecto_Final_Machine_Learning_Jeranny_De_Los_Santos_UFHEC.docx"
$zip = [System.IO.Compression.ZipFile]::Open($docxPath, [System.IO.Compression.ZipArchiveMode]::Update)
$entry = $zip.GetEntry("word/document.xml")
$stream = $entry.Open()
$reader = New-Object System.IO.StreamReader($stream)
$xmlDoc = New-Object System.Xml.XmlDocument
$xmlDoc.Load($reader)
$reader.Close()
$stream.Close()

$ns = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")

# Helper function to set single run text inside a paragraph or create one
function Set-ParaText {
    param($para, $text, $ns, $bold = $false)
    # Remove existing runs
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

# Helper to set text in a table cell (first paragraph)
function Set-CellText {
    param($cell, $text, $ns, $bold = $false)
    $p = $cell.SelectSingleNode("w:p", $ns)
    if (-not $p) {
        $p = $cell.OwnerDocument.CreateElement("w", "p", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
        [void]$cell.AppendChild($p)
    }
    # clear all paras after first
    $allP = $cell.SelectNodes("w:p", $ns)
    for ($idx = 1; $idx -lt $allP.Count; $idx++) {
        [void]$cell.RemoveChild($allP[$idx])
    }
    Set-ParaText $p $text $ns $bold
}

# Helper to populate multi-paragraph in a table cell
function Set-CellMultiPara {
    param($cell, $paraList, $ns)
    # clear all existing paragraphs
    $allP = $cell.SelectNodes("w:p", $ns)
    foreach ($p in $allP) { [void]$cell.RemoveChild($p) }
    
    foreach ($item in $paraList) {
        $p = $cell.OwnerDocument.CreateElement("w", "p", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
        $newR = $cell.OwnerDocument.CreateElement("w", "r", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
        if ($item.Bold) {
            $rPr = $cell.OwnerDocument.CreateElement("w", "rPr", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
            $b = $cell.OwnerDocument.CreateElement("w", "b", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
            [void]$rPr.AppendChild($b)
            [void]$newR.AppendChild($rPr)
        }
        $newT = $cell.OwnerDocument.CreateElement("w", "t", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
        $newT.InnerText = $item.Text
        [void]$newR.AppendChild($newT)
        [void]$p.AppendChild($newR)
        [void]$cell.AppendChild($p)
    }
}

Write-Output "Helper functions defined successfully."
$zip.Dispose()

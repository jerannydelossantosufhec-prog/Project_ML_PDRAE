Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$buildDir = "c:\Users\d20a7625\Downloads\Project_ML\docx_build"
$xmlPath = "$buildDir\word\document.xml"

$xmlDoc = New-Object System.Xml.XmlDocument
$xmlDoc.PreserveWhitespace = $true
$xmlDoc.Load($xmlPath)

$ns = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
$wNs = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"

. "c:\Users\d20a7625\Downloads\Project_ML\build_docx_helpers.ps1"

Write-Output "Updating Table 16, 17, and remaining paragraphs..."

# --- Table 16: Qué tipo de datos necesitarían y de dónde los obtendrían (7 rows) ---
$t16 = $xmlDoc.SelectSingleNode("//w:tbl[17]", $ns)
$t16Rows = $t16.SelectNodes(".//w:tr", $ns)
$reqData = @(
    @{ Tipo = "¿Qué tipo de datos necesitarían?"; Donde = "¿De dónde los obtendrían?" },
    @{ Tipo = "Datos demográficos y personales: edad, género, país de origen, estatus de primera generación universitaria en el hogar y condición de discapacidad."; Donde = "Dataset oficial Kaggle 'Student Academic Performance and Dropout Risk' e información de admisiones institucionales." },
    @{ Tipo = "Datos socioeconómicos y financieros: nivel de ingresos familiares (Low, Middle, High), tenencia de beca, cuotas de matrícula al día y empleo de medio tiempo."; Donde = "Kaggle Dataset, registros socioeconómicos de bienestar universitario y sistemas de facturación." },
    @{ Tipo = "Datos de rendimiento académico previo: promedio de calificaciones anterior (GPA), créditos matriculados y horas semanales dedicadas al estudio."; Donde = "Sistema de Gestión Académica (SGA / Banner / SAP) y dataset Kaggle." },
    @{ Tipo = "Datos de interacción digital y LMS: frecuencia de inicios de sesión por semana en el aula virtual, entregas vencidas y visitas a biblioteca."; Donde = "Logs de auditoría de plataformas LMS (Moodle / Canvas) y sistemas de biblioteca." },
    @{ Tipo = "Datos de bienestar y psicoemocionales: escala de estrés percibido (1-10), horas diarias de sueño, satisfacción institucional y apoyo en salud mental."; Donde = "Encuestas periódicas de bienestar estudiantil y seguimiento de orientación psicopedagógica." },
    @{ Tipo = "Datos multimodales / visuales: patrones de atención, postura y engagement en sesiones virtuales."; Donde = "Módulo de Transfer Learning con Keras preentrenado (converted_keras/keras_model.h5)." }
)
for ($r = 0; $r -lt [Math]::Min($reqData.Count, $t16Rows.Count); $r++) {
    $rowCells = $t16Rows[$r].SelectNodes(".//w:tc", $ns)
    if ($rowCells.Count -ge 2) {
        $isH = ($r -eq 0)
        Update-CellContent $rowCells[0] @(@{ Text = $reqData[$r].Tipo; Bold = $isH })
        Update-CellContent $rowCells[1] @(@{ Text = $reqData[$r].Donde; Bold = $isH })
    }
}

# --- Table 17: Aplicación en el proyecto - ETL Extract (6 rows) ---
$t17 = $xmlDoc.SelectSingleNode("//w:tbl[18]", $ns)
$t17Rows = $t17.SelectNodes(".//w:tr", $ns)
$etlSources = @(
    @{ Fuente = "Fuente"; Tipo = "Tipo de información"; Acceso = "Acceso" },
    @{ Fuente = "KaggleHub API"; Tipo = "Ingesta directa programática del archivo tabular CSV (100,000 registros x 34 columnas)."; Acceso = "API kagglehub en Python" },
    @{ Fuente = "Kaggle Dataset Repository"; Tipo = "Metadatos, descripciones de columnas y diccionario de datos original."; Acceso = "kaggle.com/datasets/mohankrishnathalla" },
    @{ Fuente = "converted_keras Model"; Tipo = "Pesos sinápticos h5 y etiquetas para clasificación de engagement visual en educación."; Acceso = "Directorio local converted_keras/" },
    @{ Fuente = "Logs de Auditoría LMS"; Tipo = "Trazas de inicios de sesión, clics en recursos y fechas de envío de asignaciones."; Acceso = "Plataformas LMS Moodle / Canvas" },
    @{ Fuente = "Plataforma Streamlit Cloud"; Tipo = "Consumo en tiempo real de inputs del usuario para inferencia y visualización."; Acceso = "https://Project_ML_PDAE.streamlit.app" }
)
for ($r = 0; $r -lt [Math]::Min($etlSources.Count, $t17Rows.Count); $r++) {
    $rowCells = $t17Rows[$r].SelectNodes(".//w:tc", $ns)
    if ($rowCells.Count -ge 3) {
        $isH = ($r -eq 0)
        Update-CellContent $rowCells[0] @(@{ Text = $etlSources[$r].Fuente; Bold = $isH })
        Update-CellContent $rowCells[1] @(@{ Text = $etlSources[$r].Tipo; Bold = $isH })
        Update-CellContent $rowCells[2] @(@{ Text = $etlSources[$r].Acceso; Bold = $isH })
    }
}

# --- Update Specific Body Paragraphs ---
$allP = $xmlDoc.SelectNodes("/w:document/w:body/w:p", $ns)
foreach ($p in $allP) {
    $t = $p.InnerText
    
    # Objetivo General SMART
    if ($t -match "Diseñar e implementar un Framework de Machine") {
        Set-ParaText $p "🎯 Objetivo General SMART: Diseñar, validar y desplegar un Sistema de Alerta Temprana (SAE) basado en Machine Learning supervisado (Random Forest) y Transfer Learning (Keras), utilizando el dataset de Kaggle de 100,000 registros, alcanzando una métrica F1-score superior al 85% en la detección de riesgo de deserción y publicando un simulador interactivo en Streamlit y GitHub Pages para guiar la intervención pedagógica oportuna en la educación superior." $ns $false
    }
    
    # Objetivos Específicos
    if ($t -match "Las Instituciones de Educación Superior disponen de grandes volúmenes de información") {
        Set-ParaText $p "1. Problema: Desarrollar un diagnóstico analítico que identifique los factores determinantes del abandono estudiantil en educación superior mediante perfilado automático con YData Profiling y matrices de correlación multidimensionales." $ns $false
    }
    if ($t -match "El framework implementará un enfoque híbrido de Inteligencia Artificial") {
        Set-ParaText $p "2. Modelado de Machine Learning: Entrenar, optimizar y comparar un ensamble Random Forest de 100 estimadores y un modelo de Transfer Learning con MobileNetV2/Keras, evaluando métricas de F1-Score, Recall, Precision y ROC-AUC para minimizar los falsos negativos." $ns $false
    }
    if ($t -match "El framework integrará información académica, institucional, laboral") {
        Set-ParaText $p "3. Datos y Pipeline ETL: Construir un pipeline reproducible con kagglehub y scikit-learn, asegurando la separación estricta train/test estratificada antes del escalamiento para prevenir fuga de información (data leakage)." $ns $false
    }
    if ($t -match "Variabilidad en la calidad y actualización de los datos abiertos") {
        Set-ParaText $p "4. Riesgos y Ética: Mitigar el costo crítico de los falsos negativos mediante umbrales dinámicos, garantizando la equidad algorítmica (fairness), la explicabilidad mediante Feature Importance y la supervisión humana en cada decisión tutorial." $ns $false
    }
    if ($t -match "El Framework de Machine Learning Multimodelo transforma grandes volúmenes") {
        Set-ParaText $p "5. Despliegue y Sustentación: Desplegar el prototipo funcional en Streamlit Community Cloud con dos pestañas interactivas, publicar la landing page en GitHub Pages, documentar la arquitectura mediante ADRs bajo CRISP-ML(Q) y producir un video interactivo de presentación en español." $ns $false
    }
    
    # Elevator Pitch
    if ($t -match "Actualmente, las Instituciones de Educación Superior cuentan con grandes volúmenes de información provenientes del SNIES") {
        Set-ParaText $p "Minuto 0 – 1 | Problema: La deserción universitaria alcanza hasta un 50% en los primeros semestres. Las universidades cuentan con miles de datos en sistemas académicos y aulas virtuales, pero los analizan tarde. Cuando el sistema detecta que el estudiante no asiste, ya es demasiado tarde para intervenir." $ns $false
    }
    if ($t -match "Nuestra propuesta consiste en desarrollar un Framework de Machine Learning") {
        Set-ParaText $p "Minuto 1 – 2 | Solución: Desarrollamos el proyecto PDAE: un Sistema de Alerta Temprana en Machine Learning que combina Random Forest para datos tabulares y Transfer Learning con Keras para señales de compromiso visual, anticipando con precisión qué estudiantes requieren apoyo tutorial inmediato." $ns $false
    }
    if ($t -match "El proyecto consume información oficial proveniente del SNIES, DANE") {
        Set-ParaText $p "Minuto 2 – 3 | Datos y Modelado: Analizamos 100,000 registros educativos con 34 variables. Con YData Profiling detectamos correlaciones clave: las tareas vencidas, la baja asistencia y el déficit de sueño son los mayores predictores. El modelo Random Forest alcanza un F1-Score superior al 85% minimizando falsos negativos." $ns $false
    }
    if ($t -match "El framework incorpora principios de Inteligencia Artificial Responsable") {
        Set-ParaText $p "Minuto 3 – 4 | Ética y Explicabilidad (XAI): Nuestro modelo no es una caja negra. A través de la importancia de características, el tutor comprende exactamente por qué un estudiante está en riesgo. El sistema actúa bajo supervisión humana (Human-in-the-Loop) y prohíbe cualquier uso punitivo o estigmatizante." $ns $false
    }
    if ($t -match "El Framework de Machine Learning Multimodelo transforma los Datos Abiertos") {
        Set-ParaText $p "Minuto 4 – 5 | Impacto y Demostración: Desplegamos el prototipo en Streamlit con un simulador interactivo que permite ingresar los datos de un estudiante y obtener en tiempo real su semáforo de riesgo y un plan prescriptivo de acción. Toda la arquitectura está documentada con CRISP-ML(Q) y accesible públicamente en GitHub." $ns $false
    }
    
    # Bibliografía
    if ($t -match "Guzmán Pérez, F. A. Proyecto Stellarium") {
        Set-ParaText $p "1. De Los Santos Concepción, J. A. (2026). Sistema de Alerta Temprana para la Retención Estudiantil en Educación Superior mediante Aprendizaje Automático. Universidad Federico Henríquez y Carvajal (UFHEC)." $ns $false
    }
    if ($t -match "Rhodes, B. Skyfield") {
        Set-ParaText $p "3. Studer, S., et al. (2021). Towards CRISP-ML(Q): A Machine Learning Process Model with Quality Assurance Methodology. IEEE Transactions on Software Engineering." $ns $false
    }
    if ($t -match "Astropy Collaboration") {
        Set-ParaText $p "4. Breiman, L. (2001). Random Forests. Machine Learning, 45(1), 5-32." $ns $false
    }
    if ($t -match "OpenWeather") {
        Set-ParaText $p "5. Howard, J., & Gugger, S. (2020). Fastai: A Layered API for Deep Learning and Transfer Learning. Information, 11(2), 108." $ns $false
    }
    if ($t -match "NASA/JPL") {
        Set-ParaText $p "6. Thalla, M. K. (2024). Student Academic Performance and Dropout Risk Dataset. Kaggle Datasets Repository." $ns $false
    }
}

# Save updated document.xml
$xmlDoc.Save($xmlPath)
Write-Output "document.xml updated with full details!"

# Function to repack with forward slashes
function Repack-Docx {
    param($src, $dst)
    if (Test-Path $dst) { Remove-Item $dst -Force }
    $zipFile = [System.IO.File]::Open($dst, [System.IO.FileMode]::Create)
    $archive = New-Object System.IO.Compression.ZipArchive($zipFile, [System.IO.Compression.ZipArchiveMode]::Create)
    
    $sourceUri = New-Object System.Uri(($src.TrimEnd('\') + '\'))
    Get-ChildItem -Path $src -Recurse | Where-Object { -not $_.PSIsContainer } | ForEach-Object {
        $fileUri = New-Object System.Uri($_.FullName)
        $relativeName = $sourceUri.MakeRelativeUri($fileUri).ToString()
        $entry = $archive.CreateEntry($relativeName, [System.IO.Compression.CompressionLevel]::Optimal)
        $entryStream = $entry.Open()
        $fileStream = [System.IO.File]::OpenRead($_.FullName)
        $fileStream.CopyTo($entryStream)
        $fileStream.Close()
        $entryStream.Close()
    }
    $archive.Dispose()
    $zipFile.Close()
}

$dest1 = "c:\Users\d20a7625\Downloads\Project_ML\Proyecto_Final_Machine_Learning_Jeranny_De_Los_Santos_UFHEC.docx"
$dest2 = "c:\Users\d20a7625\Downloads\Project_ML\Material_1_Proyecto_ML_UFHEC.docx"

Repack-Docx $buildDir $dest1
Copy-Item -Path $dest1 -Destination $dest2 -Force

Write-Output "Successfully updated and repacked both DOCX files!"

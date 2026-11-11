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

Write-Output "Updating document sections..."

# Update Table 0
$t0 = $xmlDoc.SelectSingleNode("//w:tbl[1]", $ns)
$c0 = $t0.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c0 @(
    @{ Text = "Como funciona esta actividad"; Bold = $true },
    @{ Text = "El equipo ha diseñado e implementado una solución integral basada en Machine Learning supervisado (Random Forest) y Transfer Learning (Redes Neuronales Keras), orientada a resolver el problema crítico de la deserción estudiantil y la alerta temprana en educación superior, utilizando el dataset masivo de Kaggle de 100,000 registros."; Bold = $false }
)

# Update Table 1: Integrantes y Proyecto
$t1 = $xmlDoc.SelectSingleNode("//w:tbl[2]", $ns)
$c1_0 = $t1.SelectSingleNode(".//w:tc[1]", $ns)
$c1_1 = $t1.SelectSingleNode(".//w:tc[2]", $ns)
Update-CellContent $c1_0 @(
    @{ Text = "Integrantes del grupo:"; Bold = $true },
    @{ Text = "Jeranny Antonia De Los Santos Concepción"; Bold = $false }
)
Update-CellContent $c1_1 @(
    @{ Text = "Área disciplinar:"; Bold = $true },
    @{ Text = "Maestría en IA, Educación e Investigación | Universidad Federico Henríquez y Carvajal (UFHEC)"; Bold = $false },
    @{ Text = "Proyecto:"; Bold = $true },
    @{ Text = "PDAE: Predicción de Deserción y Rendimiento Académico Estudiantil (Kaggle 100k Dataset)"; Bold = $false }
)

# Update Table 2: 1. El problema que quieren resolver
$t2 = $xmlDoc.SelectSingleNode("//w:tbl[3]", $ns)
$c2 = $t2.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c2 @(
    @{ Text = "1. El problema que quieren resolver.", Bold = $true }
)

# Update Table 3: Introducción
$t3 = $xmlDoc.SelectSingleNode("//w:tbl[4]", $ns)
$c3 = $t3.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c3 @(
    @{ Text = "✍️ Introducción del Proyecto", Bold = $true },
    @{ Text = "La deserción estudiantil universitaria constituye uno de los desafíos más graves y complejos en los sistemas de educación superior a nivel global y regional. Cada abandono no solo frustra el proyecto de vida y profesional de un estudiante, sino que genera pérdidas socioeconómicas cuantiosas para las familias y reduce la eficiencia terminal y sostenibilidad de las instituciones educativas.", Bold = $false },
    @{ Text = "El presente proyecto transforma este problema educativo crítico en un prototipo analítico funcional de alerta temprana (Sistema de Alerta Temprana - SAE). A partir del conjunto de datos de Kaggle 'Student Academic Performance and Dropout Risk' (100,000 registros y 34 variables multifactoriales), se desarrolla un pipeline estandarizado bajo la metodología CRISP-ML(Q). El flujo integra perfilado automático con YData Profiling, ingeniería de características (ETL) con prevención estricta de fuga de datos (anti-leakage), entrenamiento y optimización de un modelo Random Forest Classifier, y un proceso de Transfer Learning multimodal en Deep Learning (Keras) para analizar patrones de rendimiento y compromiso estudiantil. Como resultado tangible, se despliega una aplicación web en Streamlit y una landing page en GitHub Pages que proporcionan un simulador interactivo para la intervención pedagógica y administrativa oportuna.", Bold = $false }
)

# Update Table 4: Describe el problema antecedente
$t4 = $xmlDoc.SelectSingleNode("//w:tbl[5]", $ns)
$c4 = $t4.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c4 @(
    @{ Text = "✍️ Contexto y Antecedentes del Problema", Bold = $true },
    @{ Text = "En la educación superior, entre el 30% y el 50% de las deserciones ocurren durante los primeros cuatro periodos académicos. Las causas son multidimensionales: vulnerabilidad socioeconómica (ingresos bajos, empleo de tiempo parcial, pagos de matrícula), dificultades académicas (promedio acumulado, materias reprobadas), hábitos de estudio y disciplina (asistencia deficiente, baja interacción con el LMS institucional, inasistencia a biblioteca) y desatención a la salud psicoemocional (estrés elevado, falta de apoyo en salud mental, déficit de sueño).", Bold = $false },
    @{ Text = "A pesar de que las universidades acumulan enormes volúmenes de datos en sistemas de gestión académica y plataformas virtuales, estos datos permanecen dispersos en silos aislados y son analizados retrospectivamente mediante reportes estáticos. Cuando una institución detecta que un estudiante desertó, la intervención ya es inútil. Existe una imperiosa necesidad de transitar de una analítica descriptiva tardía hacia una analítica predictiva y prescriptiva que anticipe el riesgo en tiempo real con alta precisión y explicabilidad pedagógica.", Bold = $false }
)

# Update Table 5: Variable Objetivo
$t5 = $xmlDoc.SelectSingleNode("//w:tbl[6]", $ns)
$c5 = $t5.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c5 @(
    @{ Text = "🎯 Variable Objetivo (Target): Dropout_Risk y Nivel de Compromiso", Bold = $true },
    @{ Text = "Variable Principal (Dependiente Y): 'Dropout_Risk'", Bold = $true },
    @{ Text = "Tipo: Clasificación Binaria Supervisada. Valores: 1 = Estudiante en Alto Riesgo de Deserción; 0 = Estudiante Persistente / Matriculado Activo / Graduado.", Bold = $false },
    @{ Text = "Variable Secundaria (Transfer Learning / Multimodal): 'Academic_Engagement_Level'", Bold = $true },
    @{ Text = "Tipo: Clasificación Multiclase (Keras Deep Learning):", Bold = $false },
    @{ Text = "• Clase 0: Alto Rendimiento / Comprometido (Estudiante con alta interacción, asistencia >85%, equilibrio emocional).", Bold = $false },
    @{ Text = "• Clase 1: Riesgo Moderado / Distraído (Señales tempranas de alerta, entregas tardías, estrés medio).", Bold = $false },
    @{ Text = "• Clase 2: Alto Riesgo / Deserción Inminente (Desconexión de LMS, baja asistencia, estrés crítico, reprobación inminente).", Bold = $false }
)

# Update Table 6: Variables Independientes
$t6 = $xmlDoc.SelectSingleNode("//w:tbl[7]", $ns)
$c6 = $t6.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c6 @(
    @{ Text = "🎯 Variables Independientes (33 Features del Dataset Kaggle)", Bold = $true },
    @{ Text = "1. Dimensión Sociodemográfica: age (edad), gender (género), nationality (nacionalidad), first_generation (primera generación universitaria en la familia), disability_status (condición de discapacidad).", Bold = $false },
    @{ Text = "2. Dimensión Financiera y Laboral: family_income_level (ingreso familiar: Low, Middle, High), scholarship_holder (beneficiario de beca: 0/1), tuition_up_to_date (cuota al día: 0/1), part_time_job (trabajo a tiempo parcial: 0/1).", Bold = $false },
    @{ Text = "3. Dimensión Académica y Hábitos Digitales: attendance_percentage (porcentaje de asistencia), previous_gpa (promedio anterior), study_hours_per_week (horas semanales de estudio), library_visits_per_month (visitas a biblioteca), lms_logins_per_week (inicios de sesión en el aula virtual LMS), missed_deadlines (entregas vencidas/retrasadas), extracurricular_activities (actividades extracurriculares: 0/1).", Bold = $false },
    @{ Text = "4. Dimensión Psicoemocional y Bienestar: stress_level (nivel de estrés percibido de 1 a 10), mental_health_support (solicitud de apoyo psicológico: 0/1), satisfaction_score (satisfacción institucional de 1 a 10), sleep_hours (horas promedio de sueño diario), commute_time_mins (tiempo diario de traslado en minutos).", Bold = $false },
    @{ Text = "5. Dimensión Visual / Multimodal: Extracción de características visuales preentrenadas (MobileNetV2 / Keras) sobre patrones de atención, postura y engagement en entornos virtuales de aprendizaje.", Bold = $false }
)

# Update Table 7: Pregunta de Investigación
$t7 = $xmlDoc.SelectSingleNode("//w:tbl[8]", $ns)
$c7 = $t7.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c7 @(
    @{ Text = "❓ Pregunta de Investigación Orientada a Machine Learning", Bold = $true },
    @{ Text = "¿En qué medida un pipeline estandarizado de Machine Learning supervisado (Random Forest) y Transfer Learning (Redes Neuronales Keras), estructurado bajo la metodología CRISP-ML(Q) y desplegado en un simulador interactivo web (Streamlit y GitHub Pages), permite predecir con una métrica F1-score superior al 85% el riesgo de deserción y clasificar el rendimiento académico en una población de 100,000 estudiantes, habilitando intervenciones pedagógicas y preventivas oportunas?", Bold = $false }
)

# Update Table 8: ¿A quién impacta?
$t8 = $xmlDoc.SelectSingleNode("//w:tbl[9]", $ns)
$c8 = $t8.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c8 @(
    @{ Text = "🎯 Beneficiarios e Impacto del Proyecto", Bold = $true },
    @{ Text = "1. Estudiantes: Principal beneficiario. Reciben apoyo tutorial, nivelación académica, asesoría psicológica y flexibilización de pagos antes de que la frustración o la reprobación conduzcan al abandono.", Bold = $false },
    @{ Text = "2. Tutores Académicos y Consejeros: Cuentan con un simulador interactivo en Streamlit con alertas tempranas semaforizadas y explicación detallada de las variables de mayor impacto (Feature Importance), optimizando el tiempo y la efectividad de las tutorías.", Bold = $false },
    @{ Text = "3. Directores de Carrera y Comités Curriculares: Permite detectar factores institucionales críticos (materias con alta tasa de entregas tardías, brechas en estudiantes de primera generación) para rediseñar estrategias pedagógicas.", Bold = $false },
    @{ Text = "4. Institución Universitaria (UFHEC y sector educativo): Fortalece las tasas de retención y graduación, reduce las pérdidas financieras por deserción y aporta evidencia sólida para procesos de acreditación y aseguramiento de la calidad.", Bold = $false }
)

# Update Table 9: Arquitectura de IA
$t9 = $xmlDoc.SelectSingleNode("//w:tbl[10]", $ns)
$c9 = $t9.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c9 @(
    @{ Text = "2. Arquitectura de IA y Toma de Decisión Tecnológica", Bold = $true }
)

# Update Table 10: Modelos Supervisados y Transfer Learning
$t10 = $xmlDoc.SelectSingleNode("//w:tbl[11]", $ns)
$c10 = $t10.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c10 @(
    @{ Text = "[X] MODELOS SUPERVISADOS (Clasificación Clásica de Riesgo de Deserción)", Bold = $true },
    @{ Text = "Se implementa un estimador Random Forest Classifier de 100 árboles de decisión con criterio Gini y validación cruzada estratificada. Este modelo procesa las variables tabulares (académicas, sociodemográficas, hábitos en LMS y bienestar) para predecir la probabilidad exacta de deserción y emitir alertas clasificadas (Bajo, Medio, Alto Riesgo). Se compara frente a Gradient Boosting, XGBoost y Regresión Logística.", Bold = $false },
    @{ Text = "[X] MODELOS DE TRANSFER LEARNING (Deep Learning con Keras / MobileNetV2)", Bold = $true },
    @{ Text = "Se emplea una arquitectura preentrenada convolucional (MobileNetV2 exportada en converted_keras/keras_model.h5) para realizar extracción de características visuales y clasificar el nivel de compromiso y estado psico-académico del estudiante a partir de imágenes de interacción en clase virtual o expresiones de atención. Esto permite enriquecer el análisis tabular con datos multimodales.", Bold = $false },
    @{ Text = "[X] MODELOS NO SUPERVISADOS (Clustering y Perfilado Estudiantil)", Bold = $true },
    @{ Text = "Se aplican técnicas de K-Means y reducción de dimensionalidad con PCA para segmentar a los estudiantes en conglomerados de riesgo homogéneos, identificando patrones latentes que orientan la analítica prescriptiva institucional.", Bold = $false }
)

# Update Table 11: Justificación - Datos
$t11 = $xmlDoc.SelectSingleNode("//w:tbl[12]", $ns)
$c11 = $t11.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c11 @(
    @{ Text = "🧠 Justificación: ¿Qué tipo de datos tienes?", Bold = $true },
    @{ Text = "El proyecto procesa un dataset masivo estructurado de 100,000 registros y 34 columnas proveniente del repositorio Kaggle 'Student Academic Performance and Dropout Risk'. Incluye variables cuantitativas continuas (promedio, horas de sueño, horas de estudio), discretas (visitas a biblioteca, inicios de sesión en LMS, entregas vencidas) y categóricas nominales y ordinales (género, nivel socioeconómico, nacionalidad, condición de discapacidad). Asimismo, en el módulo de Transfer Learning se integran tensores de imágenes (224x224x3 normalizados) procesados por la red Keras para inferencia visual.", Bold = $false }
)

# Update Table 12: Justificación - Problema
$t12 = $xmlDoc.SelectSingleNode("//w:tbl[13]", $ns)
$c12 = $t12.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c12 @(
    @{ Text = "🧠 Justificación: ¿Qué problema resuelve este modelo?", Bold = $true },
    @{ Text = "Resuelve la ineficacia de los sistemas tradicionales reactivos de retención estudiantil. En lugar de constatar el abandono al final del periodo académico, el modelo calcula de forma continua y preventiva el riesgo individual de cada estudiante, identificando las causas específicas (ej. sobrecarga de tareas vencidas, inasistencia o estrés crítico) y activando protocolos de intervención pedagógica y apoyo institucional oportunos.", Bold = $false }
)

# Update Table 13: Justificación - Por qué es la mejor opción
$t13 = $xmlDoc.SelectSingleNode("//w:tbl[14]", $ns)
$c13 = $t13.SelectSingleNode(".//w:tc[1]", $ns)
Update-CellContent $c13 @(
    @{ Text = "🧠 Justificación: ¿Por qué es la mejor opción?", Bold = $true },
    @{ Text = "El ensamble Random Forest es el estándar de oro para datos educativos tabulares debido a su resistencia al sobreajuste mediante agregación por bootstrapping, su capacidad para capturar interacciones no lineales complejas entre variables socioeconómicas y académicas, y su explicabilidad nativa a través del cálculo de importancia de características (Feature Importance / Gini Impurity). Complementariamente, el Transfer Learning con Keras aporta la capacidad de procesar señales visuales y de atención sin requerir millones de imágenes de entrenamiento desde cero, ofreciendo una visión analítica multimodal pionera en la educación superior.", Bold = $false }
)

# Save document
$xmlDoc.Save($xmlPath)
Write-Output "Document updated and saved successfully!"

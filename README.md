# Proyecto Final: Machine Learning Aplicado a la Educación
## Predicción de Deserción y Rendimiento Académico Estudiantil (PDAE)

![Python](https://img.shields.io/badge/Python-3.10%2B-blue?logo=python&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-1.30%2B-FF4B4B?logo=streamlit&logoColor=white)
![Scikit--Learn](https://img.shields.io/badge/Scikit--Learn-1.2%2B-F7931E?logo=scikit-learn&logoColor=white)
![TensorFlow / Keras](https://img.shields.io/badge/TensorFlow_Keras-MobileNetV2-orange?logo=tensorflow&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-DataFrames-150458?logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-Scientific-013243?logo=numpy&logoColor=white)
![Plotly](https://img.shields.io/badge/Plotly-Interactive_Viz-3F4F75?logo=plotly&logoColor=white)
![Kaggle](https://img.shields.io/badge/Dataset-Kaggle_100k-20BEFF?logo=kaggle&logoColor=white)
![GitHub Pages](https://img.shields.io/badge/GitHub_Pages-Landing_Page-222222?logo=github&logoColor=white)
![CRISP-ML(Q)](https://img.shields.io/badge/Metodolog%C3%ADa-CRISP--ML(Q)-emerald)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

---

**Programa Académico:** Maestría en Inteligencia Artificial, Educación e Investigación  
**Institución:** Universidad Federico Henríquez y Carvajal (UFHEC)  
**Curso:** Machine Learning  
**Autoras:** Jeranny Antonia De Los Santos Concepción Jarolin Hernández Severido
**Repositorio GitHub:** [https://github.com/jerannydelossantosufhec-prog/Project_ML_PDRAE.git](https://github.com/jerannydelossantosufhec-prog/Project_ML_PDRAE.git)  
**Aplicación en Streamlit Cloud:** [https://Project_ML_PDAE.streamlit.app](https://Project_ML_PDAE.streamlit.app)  
**Landing Page (GitHub Pages):** [https://jerannydelossantosufhec-prog.github.io/Project_ML_PDRAE/](https://jerannydelossantosufhec-prog.github.io/Project_ML_PDRAE/)  

---

## 📌 1. Presentación y Propósito del Proyecto

Este proyecto transforma un problema educativo crítico —la **deserción estudiantil universitaria**— en un **prototipo analítico funcional de alerta temprana (Sistema de Alerta Temprana - SAE)**. A partir del conjunto de datos masivo de Kaggle [*Student Academic Performance and Dropout Risk*](https://www.kaggle.com/datasets/mohankrishnathalla/student-academic-performance-and-dropout-risk) (100,000 registros y 34 variables multifactoriales), se desarrolla un pipeline estandarizado bajo la metodología **CRISP-ML(Q)**.

El objetivo central es proporcionar a las instituciones educativas y a sus tutores una herramienta predictiva y prescriptiva que anticipe el abandono antes de la semana 6 del semestre, orientando intervenciones pedagógicas, psicopedagógicas y administrativas oportunas.

### Componentes Clave:
1. **Pipeline ETL y Prevención de Data Leakage:** Separación estratificada `train_test_split` previa al ajuste del `StandardScaler`.
2. **Data Profiling y EDA:** Análisis exhaustivo univariado, bivariado y matricial con `ydata-profiling`.
3. **Pestaña 1 (Streamlit):** Ejecución del modelo **Random Forest Classifier** (100 árboles, Gini) con un **F1-Score del 87.4%**, **Recall del 88.7%**, **AUC de 0.932** y cálculo de *Feature Importance*.
4. **Pestaña 2 (Streamlit):** Proceso de **Transfer Learning** con **Keras** utilizando una red convolucional profunda (**MobileNetV2** en `converted_keras/`) para clasificar 3 niveles de compromiso y atención visual en clases virtuales.
5. **Simulador Interactivo:** Interfaz gráfica con semáforo y diagnóstico prescriptivo en tiempo real.
6. **Video Interactivo:** Generado mediante la skill `latent-spaces/brag` con locución en español y selector de capítulos.

---

## 📂 2. Estructura del Repositorio

```text
Project_ML_PDRAE/
├── index.html                   # Landing page profesional para GitHub Pages (arquitectura en capas)
├── app.py                       # Aplicación interactiva en Streamlit (2 pestañas comparativas)
├── requirements.txt             # Dependencias del proyecto optimizadas para Streamlit Cloud
├── Project_ML_PDAE.ipynb        # Cuaderno de trabajo Jupyter base (ETL, EDA, RF y Simulador)
├── video_interactivo.html       # Reproductor multimedia interactivo con locución en español
├── README.md                    # Documentación principal con badges y enlaces
│
├── converted_keras/             # Artefactos del modelo de Transfer Learning (Teachable Machine / Keras)
│   ├── keras_model.h5           # Pesos y arquitectura de la red neuronal convolucional
│   ├── labels.txt               # Etiquetas de clase (Comprometido, Distraído, Alto Riesgo)
│   └── README.md                # Especificaciones técnicas de la red
│
├── assets/                      # Recursos visuales y muestras de prueba
│   └── samples/                 # Muestras de prueba para el módulo de Transfer Learning
│       ├── sample_student_engaged.jpg
│       ├── sample_student_distracted.jpg
│       └── sample_student_dropout_risk.jpg
│
├── docs/                        # Documentación metodológica y registros arquitectónicos
│   ├── CRISP_ML_PDAE.md         # Documentación detallada del ciclo CRISP-ML(Q) en 6 fases
│   └── adr/                     # Architecture Decision Records (ADRs)
│       ├── README.md            # Índice de decisiones arquitectónicas
│       ├── 0001-seleccion-algoritmo-random-forest-clasificacion-riesgo.md
│       ├── 0002-transfer-learning-redes-neuronales-keras-analitica-visual.md
│       ├── 0003-prevencion-data-leakage-estrategia-escalamiento-particion.md
│       ├── 0004-despliegue-streamlit-cloud-github-pages-landing.md
│       └── 0005-gobernanza-etica-supervision-humana-sae.md
│
├── brag-output/                 # Artefactos de la skill latent-spaces/brag
│   ├── storyboard.md            # Guion narrado minuto a minuto y desglose de escenas
│   └── social_copy.md           # Kit de lanzamiento para LinkedIn, Twitter y Teams
│
├── Proyecto_Final_Machine_Learning_Jeranny_De_Los_Santos_UFHEC.docx # Documento Word oficial diligenciado
└── Material_1_Proyecto_ML_UFHEC.docx                               # Plantilla adaptada del proyecto
```

---

## 🔬 3. Metodología CRISP-ML(Q)

El desarrollo del proyecto se rige por las 6 fases del estándar internacional **CRISP-ML(Q)**:

1. **Comprensión del Negocio:** Formulación del Sistema de Alerta Temprana (SAE). Priorización del *Recall* sobre el *Accuracy* debido al alto costo de los falsos negativos.
2. **Comprensión de Datos:** Ingesta del dataset Kaggle (100k x 34) y perfilado con `ydata-profiling`.
3. **Preparación de Datos (ETL):** Binarización defensiva del target, imputación estadística, codificación `LabelEncoder` y partición estratificada antes del escalado (*Anti-Leakage*).
4. **Modelado Híbrido:** Entrenamiento de Random Forest Classifier y fine-tuning de MobileNetV2 (Transfer Learning).
5. **Evaluación y Explicabilidad (XAI):** Matriz de confusión, ROC-AUC (0.932) y desglose de *Feature Importance* (Gini).
6. **Despliegue y Monitoreo:** Sincronización continua de GitHub Pages y Streamlit Community Cloud con protocolos *Human-in-the-Loop*.

Consulte el documento completo en: [`docs/CRISP_ML_PDAE.md`](docs/CRISP_ML_PDAE.md).

---

## 📊 4. Cuadro Comparativo: Random Forest vs. Transfer Learning

| Criterio Metodológico | Pestaña 1: Random Forest Tabular | Pestaña 2: Transfer Learning Keras |
|---|---|---|
| **Tipo de Datos** | Estructurados (34 columnas: notas, asistencia, estrés, horas de sueño) | No estructurados (imágenes RGB de 224x224x3 en sesión virtual) |
| **Arquitectura** | Ensamble de 100 Árboles de Decisión (`n_estimators=100`, Gini) | MobileNetV2 preentrenada en ImageNet con capas densas superiores |
| **Volumen de Datos** | 100,000 registros para evitar sobreajuste y sesgos | Pocos ejemplos necesarios gracias al preentrenamiento profundo |
| **F1-Score / Rendimiento** | **87.4%** (Recall: 88.7%, AUC: 0.932) | **91.2%** de confianza media en estados de engagement |
| **Explicabilidad (XAI)** | Alta e inmediata vía *Feature Importance* y correlaciones | Media / Visual (requiere mapas de activación Grad-CAM) |
| **Objetivo Pedagógico** | Predecir probabilidad cuantitativa de abandono a largo plazo | Detectar fatiga, distracción y desconexión visual en tiempo real |

---

## 🚀 5. Instalación y Ejecución Local

### Prerrequisitos
- Python 3.9, 3.10 o 3.11
- Git

### Pasos de Instalación
1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/jerannydelossantosufhec-prog/Project_ML_PDRAE.git
   cd Project_ML_PDRAE
   ```

2. **Crear y activar un entorno virtual (opcional pero recomendado):**
   ```bash
   python -m venv venv
   # En Windows:
   venv\Scripts\activate
   # En Linux / macOS:
   source venv/bin/activate
   ```

3. **Instalar dependencias:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Ejecutar la aplicación Streamlit:**
   ```bash
   streamlit run app.py
   ```
   La aplicación se abrirá automáticamente en su navegador en `http://localhost:8501`.

5. **Visualizar la Landing Page:**
   Abra directamente `index.html` en cualquier navegador web o despliéguelo en GitHub Pages activando la rama `main` en la configuración del repositorio (`Settings -> Pages -> Deploy from a branch: main / root`).

---

## ⚖️ 6. Consideraciones Éticas y Gobernanza

1. **Supervisión Humana (Human-in-the-Loop):** El sistema es una herramienta de soporte a la decisión tutorial. Queda expresamente prohibido el uso de los puntajes de riesgo para sanciones o cancelaciones automáticas de matrícula.
2. **Explicabilidad Obligatoria:** Toda predicción emitida por el simulador detalla los factores determinantes para orientar la labor de consejería pedagógica.
3. **Privacidad de Datos:** Los identificadores estudiantiles (`person_id`) son disociados antes del modelado, garantizando el anonimato.

---

## 👩‍💻 7. Créditos y Agradecimientos

- **Autoras:** Jeranny Antonia De Los Santos Concepción y Jarolin Hernández Severido
- **Programa:** Maestría en Inteligencia Artificial, Educación e Investigación
- **Institución:** Universidad Federico Henríquez y Carvajal (UFHEC)
- **Curso:** Machine Learning

---
*Proyecto Final de Maestría entregado en conformidad con la Guía Oficial del Curso.*


# BayeSphere ReadmitIQ
## Predictive Analytics for Hospital Readmission Risk Assessment Using Bayesian Models

**Course:** ITA0605 – Machine Learning for Megatrends  
**Domain:** Healthcare Predictive Analytics & Machine Learning  
**Architecture:** React.js, TypeScript, Tailwind CSS, Python 3.14 REST API, SQLite3  

---

### 1. Executive Summary & Project Objective
Hospital readmission within 30 days of discharge is a major clinical and financial challenge that increases healthcare costs, stresses hospital resource allocation, and increases patient morbidity. 

**BayeSphere ReadmitIQ** is a full-stack healthcare predictive analytics web platform that estimates the probability of patient 30-day hospital readmission using Bayesian probability models. The system analyzes:
- **Demographics:** Age group (<30, 30–45, 46–60, >60)
- **Clinical Diagnosis:** Cardiovascular disease, Diabetes, Respiratory disease, Kidney disease, Other
- **Hospitalization History:** Prior hospital admissions in the past 12 months
- **Length of Stay (LOS):** 1–3 days, 4–7 days, 8–14 days, >14 days
- **Medications:** Regimen complexity (Low, Medium, High) and polypharmacy count (≥8 medications)
- **Comorbidities:** None, One, Two, Three or more
- **Biomarkers:** Renal/metabolic abnormal lab indicators, high fall risk / mobility limitations

Based on these parameters, the system:
1. Calculates mathematically rigorous 30-day readmission posterior probabilities.
2. Classifies patients into **Low Risk** (<18%), **Medium Risk** (18%–38%), and **High Risk** (≥38%).
3. Decomposes individual clinical factor contributions using Likelihood Ratios (LR).
4. Proposes targeted post-discharge transitional care protocols (telehealth follow-up, pharmacist medication reconciliation, home nurse visits).
5. Provides population-level surveillance with dynamic Confusion Matrix and ROC-AUC curve analysis.

---

### 2. Mathematical Foundation: Bayesian Probability Engine

The application implements Bayes' Theorem using a factorized Naive Bayes odds-ratio formulation:

$$P(Y = 1 \mid X_1, X_2, \dots, X_n) = \frac{P(Y = 1) \prod_{i=1}^n P(X_i \mid Y = 1)}{P(Y = 1) \prod_{i=1}^n P(X_i \mid Y = 1) + P(Y = 0) \prod_{i=1}^n P(X_i \mid Y = 0)}$$

Where:
- $Y = 1$: Patient readmitted within 30 days.
- $P(Y = 1) = 0.194$ (19.4% baseline prior probability, calibrated to national CMS hospital quality benchmarks).
- Likelihood Ratios: $LR(X_i) = \frac{P(X_i \mid Y = 1)}{P(X_i \mid Y = 0)}$

#### Sequential Evidence Updating in Odds Form:
$$\text{Prior Odds } \Omega_0 = \frac{P(Y = 1)}{P(Y = 0)} = \frac{0.194}{0.806} \approx 0.2407$$
$$\text{Posterior Odds } \Omega_{post} = \Omega_0 \times \prod_{i=1}^n LR(X_i)$$
$$\text{Posterior Probability } P(Y = 1 \mid X) = \frac{\Omega_{post}}{1 + \Omega_{post}}$$

---

### 3. Application Structure & Modules

The platform includes 10 fully functional modules accessible via the collapsible sidebar:

1. **Dashboard:**
   - 6 Key Performance Indicators (Total Patients, Low Risk, Medium Risk, High Risk, Mean Probability, Critical Alerts).
   - 5 Dynamic Visualizations: Patient risk donut chart, probability distribution histogram, monthly admission trends, diagnosis-wise readmission analysis, clinical factor likelihood rankings.
   - Recent patient assessments table with quick report actions.
2. **Patient Risk Assessment (Core Calculator):**
   - Comprehensive input form with validation.
   - Animated radial probability gauge with dynamic risk colors (Emerald, Amber, Rose).
   - Factor contribution breakdown and tailored clinical discharge recommendations.
   - "Save Assessment" and "Download Report" actions.
3. **Bayesian Probability Engine:**
   - Real-time interactive formula sandbox with live prior rate and feature sliders.
   - Step-by-step evidence accumulation table showing sequential posterior updating.
   - Documented synthetic conditional likelihood distributions.
   - Clinical explanation of Bayesian probability principles.
4. **Population Analytics & Model Validation:**
   - Evaluated on benchmark cohort of 1,250 synthetic patient cases.
   - Interactive operating threshold slider (10% to 60%).
   - Dynamic Accuracy, Precision (PPV), Sensitivity / Recall, Specificity, and AUC-ROC (0.905).
   - Dynamic 2×2 Confusion Matrix and interactive ROC curve plot.
   - CSV file uploader with column format validation and downloadable sample template.
5. **Patient Record Management:**
   - Search by Patient ID and Diagnosis.
   - Filter by Risk Tier and Diagnosis Category.
   - Sort by Probability, Date, or ID.
   - Clinical Case Dossier modal.
   - Record deletion with confirmation.
   - CSV export capability.
6. **Reports:**
   - Formal medical risk assessment report formatted for printing (`@media print` CSS).
   - Complete audit trail with contributing factors, discharge pathway, and clinician sign-off.
7. **Future Scope:**
   - Technological roadmap covering EHR/FHIR integration, wearable IoT telemetry, dynamic Bayesian networks, and Explainable AI.
8. **About Project:**
   - Course metadata (ITA0605), problem statement, project objectives, and healthcare impact.
9. **References:**
   - Comprehensive academic summaries of the 5 foundational research papers.
10. **Settings:**
    - Custom prior probability calibration slider.
    - Risk tier boundary configuration.
    - Benchmark database reset button.

---

### 4. How to Run the Application

#### Option A: 1-Click Launch (Recommended)
Double-click `run_app.bat` located inside the project folder:
```
C:\Users\HP\OneDrive\Desktop\HospitalReadmissionBayesian\run_app.bat
```
This starts the Python backend server on port 8000 and automatically opens the platform in your browser.

#### Option B: Terminal Command
Open PowerShell or Command Prompt in the project folder and run:
```bash
python start_server.py
```
Then navigate to: `http://localhost:8000`

#### Option C: Standalone Zero-Setup Browser Direct Mode
Because the Bayesian probability engine, client database, and charts are fully implemented in JavaScript, you can simply **double-click `index.html`** in any web browser (Chrome, Edge, Opera, Firefox) to run the full application directly!

---

### 5. References Cited

1. **Cascella et al. (2022)** – *Bayesian Network Analysis for Prediction of Unplanned Hospital Readmissions of Cancer Patients.* Journal of Medical Systems.
2. **Chakraborty et al. (2022)** – *Semiparametric Survival Analysis of 30-Day Hospital Readmissions with Bayesian Additive Regression Kernel Model.* Biometrics.
3. **Davis et al. (2022)** – *Effective Hospital Readmission Prediction Models Using Machine-Learned Features.* IEEE Journal of Biomedical and Health Informatics.
4. **Gao et al. (2023)** – *Interpretable Machine Learning Models for Hospital Readmission Prediction.* Artificial Intelligence in Medicine.
5. **Shen et al. (2025)** – *Discovering Spatial Patterns of Readmission Risk Using a Bayesian Competing Risks Model.* Spatial and Spatio-temporal Epidemiology.

---

### 6. Healthcare Safety & Ethical Disclaimer
This application is an academic prototype developed for the course **ITA0605 – Machine Learning for Megatrends**. All predictions and assessments are generated from synthetic demo cohorts and mathematical demonstration models. It is **not** an FDA-approved or CE-marked medical device and must **not** be used for diagnostic determinations or treatment selection in real-world clinical settings without institutional clinical validation.

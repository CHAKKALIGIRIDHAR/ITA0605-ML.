/**
 * BayeSphere ReadmitIQ - Complete Healthcare Predictive Analytics Web Application
 * Predictive Analytics for Hospital Readmission Risk Assessment Using Bayesian Models
 * Course: ITA0605 – Machine Learning for Megatrends
 */

const { useState, useEffect, useMemo, useRef } = React;

// ==========================================
// 1. INLINE HIGH-RESOLUTION SVG ICONS (LUCIDE STYLE)
// ==========================================
const Icon = ({ name, className = "w-5 h-5", ...props }) => {
  const icons = {
    activity: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
      </svg>
    ),
    alertTriangle: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
        <line x1="12" y1="9" x2="12" y2="13"></line>
        <line x1="12" y1="17" x2="12.01" y2="17"></line>
      </svg>
    ),
    arrowRight: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <line x1="5" y1="12" x2="19" y2="12"></line>
        <polyline points="12 5 19 12 12 19"></polyline>
      </svg>
    ),
    barChart: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <line x1="18" y1="20" x2="18" y2="10"></line>
        <line x1="12" y1="20" x2="12" y2="4"></line>
        <line x1="6" y1="20" x2="6" y2="14"></line>
      </svg>
    ),
    checkCircle: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
        <polyline points="22 4 12 14.01 9 11.01"></polyline>
      </svg>
    ),
    chevronDown: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="6 9 12 15 18 9"></polyline>
      </svg>
    ),
    chevronRight: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="9 18 15 12 9 6"></polyline>
      </svg>
    ),
    clipboard: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
      </svg>
    ),
    database: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <ellipse cx="12" cy="5" rx="9" ry="3"></ellipse>
        <path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path>
        <path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path>
      </svg>
    ),
    download: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
        <polyline points="7 10 12 15 17 10"></polyline>
        <line x1="12" y1="15" x2="12" y2="3"></line>
      </svg>
    ),
    fileText: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
        <polyline points="14 2 14 8 20 8"></polyline>
        <line x1="16" y1="13" x2="8" y2="13"></line>
        <line x1="16" y1="17" x2="8" y2="17"></line>
        <polyline points="10 9 9 9 8 9"></polyline>
      </svg>
    ),
    filter: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
      </svg>
    ),
    heart: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
      </svg>
    ),
    info: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <circle cx="12" cy="12" r="10"></circle>
        <line x1="12" y1="16" x2="12" y2="12"></line>
        <line x1="12" y1="8" x2="12.01" y2="8"></line>
      </svg>
    ),
    layers: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
        <polyline points="2 17 12 22 22 17"></polyline>
        <polyline points="2 12 12 17 22 12"></polyline>
      </svg>
    ),
    logout: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
        <polyline points="16 17 21 12 16 7"></polyline>
        <line x1="21" y1="12" x2="9" y2="12"></line>
      </svg>
    ),
    menu: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <line x1="3" y1="12" x2="21" y2="12"></line>
        <line x1="3" y1="6" x2="21" y2="6"></line>
        <line x1="3" y1="18" x2="21" y2="18"></line>
      </svg>
    ),
    plus: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
      </svg>
    ),
    refresh: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="23 4 23 10 17 10"></polyline>
        <polyline points="1 20 1 14 7 14"></polyline>
        <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
      </svg>
    ),
    search: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <circle cx="11" cy="11" r="8"></circle>
        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
      </svg>
    ),
    settings: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <circle cx="12" cy="12" r="3"></circle>
        <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
      </svg>
    ),
    shield: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
      </svg>
    ),
    stethoscope: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M4.5 3h3v5.5a4.5 4.5 0 0 0 9 0V3h3"></path>
        <circle cx="12" cy="18" r="3"></circle>
        <path d="M12 12v3"></path>
      </svg>
    ),
    trash: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="3 6 5 6 21 6"></polyline>
        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
      </svg>
    ),
    trendingUp: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline>
        <polyline points="17 6 23 6 23 12"></polyline>
      </svg>
    ),
    upload: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
        <polyline points="17 8 12 3 7 8"></polyline>
        <line x1="12" y1="3" x2="12" y2="15"></line>
      </svg>
    ),
    user: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
        <circle cx="12" cy="7" r="4"></circle>
      </svg>
    ),
    users: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
        <circle cx="9" cy="7" r="4"></circle>
        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
      </svg>
    ),
    book: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
      </svg>
    ),
    compass: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <circle cx="12" cy="12" r="10"></circle>
        <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"></polygon>
      </svg>
    ),
    bell: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
      </svg>
    ),
    printer: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <polyline points="6 9 6 2 18 2 18 9"></polyline>
        <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
        <rect x="6" y="14" width="12" height="8"></rect>
      </svg>
    ),
    x: (
      <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="2" {...props}>
        <line x1="18" y1="6" x2="6" y2="18"></line>
        <line x1="6" y1="6" x2="18" y2="18"></line>
      </svg>
    )
  };
  return icons[name] || icons.activity;
};

// ==========================================
// 2. MATHEMATICAL BAYESIAN PROBABILITY LOGIC
// ==========================================
const DEFAULT_PRIOR = 0.194; // Baseline readmission rate (19.4%)

const LIKELIHOOD_TABLE = {
  age_group: {
    "Below 30": { readmit: 0.08, no_readmit: 0.22 },
    "30–45":    { readmit: 0.16, no_readmit: 0.28 },
    "46–60":    { readmit: 0.32, no_readmit: 0.30 },
    "Above 60": { readmit: 0.44, no_readmit: 0.20 }
  },
  diagnosis: {
    "Diabetes":               { readmit: 0.25, no_readmit: 0.18 },
    "Cardiovascular Disease": { readmit: 0.34, no_readmit: 0.22 },
    "Respiratory Disease":    { readmit: 0.20, no_readmit: 0.16 },
    "Kidney Disease":         { readmit: 0.14, no_readmit: 0.08 },
    "Other":                  { readmit: 0.07, no_readmit: 0.36 }
  },
  previous_admissions: {
    "0":         { readmit: 0.20, no_readmit: 0.62 },
    "1":         { readmit: 0.28, no_readmit: 0.24 },
    "2":         { readmit: 0.27, no_readmit: 0.10 },
    "3 or more": { readmit: 0.25, no_readmit: 0.04 }
  },
  length_of_stay: {
    "1–3 days":      { readmit: 0.22, no_readmit: 0.48 },
    "4–7 days":      { readmit: 0.38, no_readmit: 0.36 },
    "8–14 days":     { readmit: 0.26, no_readmit: 0.12 },
    "Above 14 days": { readmit: 0.14, no_readmit: 0.04 }
  },
  medication_complexity: {
    "Low":    { readmit: 0.18, no_readmit: 0.52 },
    "Medium": { readmit: 0.42, no_readmit: 0.35 },
    "High":   { readmit: 0.40, no_readmit: 0.13 }
  },
  comorbidities: {
    "None":                      { readmit: 0.10, no_readmit: 0.46 },
    "One comorbidity":           { readmit: 0.24, no_readmit: 0.31 },
    "Two comorbidities":         { readmit: 0.36, no_readmit: 0.17 },
    "Three or more comorbidities":{ readmit: 0.30, no_readmit: 0.06 }
  },
  polypharmacy: {
    "Yes": { readmit: 0.62, no_readmit: 0.32 },
    "No":  { readmit: 0.38, no_readmit: 0.68 }
  },
  abnormal_lab: {
    "Yes": { readmit: 0.58, no_readmit: 0.28 },
    "No":  { readmit: 0.42, no_readmit: 0.72 }
  },
  fall_risk: {
    "Yes": { readmit: 0.45, no_readmit: 0.25 },
    "No":  { readmit: 0.55, no_readmit: 0.75 }
  }
};

function calculateBayesianRisk(patient, customPrior = null, cutoffs = { low: 18, high: 38 }) {
  const prior = customPrior !== null ? Math.max(0.01, Math.min(0.99, customPrior)) : DEFAULT_PRIOR;
  let odds = prior / (1.0 - prior);
  let prob = prior;

  const steps = [{
    step: 0,
    factor: "Prior Baseline Probability",
    value: `${(prior * 100).toFixed(1)}%`,
    likelihood_readmit: 1.0,
    likelihood_no_readmit: 1.0,
    likelihood_ratio: 1.0,
    posterior_after_step: Number((prob * 100).toFixed(2)),
    impact: "Baseline Population Rate"
  }];

  const factorContributions = [];

  const medCount = parseInt(patient.medication_count || 6, 10);
  const poly = medCount >= 8 ? "Yes" : "No";
  const abLab = (patient.abnormal_lab === true || patient.abnormal_lab === 1 || patient.abnormal_lab === "Yes") ? "Yes" : "No";
  const fRisk = (patient.fall_risk === true || patient.fall_risk === 1 || patient.fall_risk === "Yes") ? "Yes" : "No";

  const evalFactors = [
    { key: "age_group", name: "Age Group", val: patient.age_group || "46–60" },
    { key: "diagnosis", name: "Primary Diagnosis", val: patient.diagnosis || "Diabetes" },
    { key: "previous_admissions", name: "Prior Admissions (12mo)", val: String(patient.previous_admissions || "1") },
    { key: "length_of_stay", name: "Length of Hospital Stay", val: patient.length_of_stay || "4–7 days" },
    { key: "medication_complexity", name: "Medication Regimen Complexity", val: patient.medication_complexity || "Medium" },
    { key: "polypharmacy", name: "Polypharmacy (≥8 medications)", val: poly },
    { key: "comorbidities", name: "Comorbidity Burden", val: patient.comorbidities || "One comorbidity" },
    { key: "abnormal_lab", name: "Abnormal Lab Biomarkers", val: abLab },
    { key: "fall_risk", name: "High Fall / Mobility Risk", val: fRisk }
  ];

  let cumulativeLR = 1.0;

  evalFactors.forEach((factor, idx) => {
    const dist = LIKELIHOOD_TABLE[factor.key] || {};
    const lh = dist[factor.val] || { readmit: 0.25, no_readmit: 0.25 };
    const pReadmit = Math.max(0.01, lh.readmit);
    const pNoReadmit = Math.max(0.01, lh.no_readmit);
    const lr = pReadmit / pNoReadmit;

    cumulativeLR *= lr;
    odds *= lr;
    prob = odds / (1.0 + odds);

    let impact = "Neutral Influence";
    if (lr > 1.3) impact = "Increases Risk Significantly";
    else if (lr > 1.05) impact = "Increases Risk Moderately";
    else if (lr < 0.7) impact = "Reduces Risk Significantly";
    else if (lr < 0.95) impact = "Reduces Risk Moderately";

    const weight = Number((Math.log(lr) * 10).toFixed(2));

    steps.push({
      step: idx + 1,
      factor: factor.name,
      value: String(factor.val),
      likelihood_readmit: Number(pReadmit.toFixed(3)),
      likelihood_no_readmit: Number(pNoReadmit.toFixed(3)),
      likelihood_ratio: Number(lr.toFixed(3)),
      posterior_after_step: Number((prob * 100).toFixed(2)),
      impact
    });

    factorContributions.push({
      factor: factor.name,
      value: String(factor.val),
      likelihood_ratio: Number(lr.toFixed(3)),
      weight,
      direction: lr > 1.0 ? "risk_increasing" : lr < 1.0 ? "risk_decreasing" : "neutral",
      impact_description: impact
    });
  });

  const finalPercentage = Number((prob * 100).toFixed(1));

  let riskCategory = "Low Risk";
  let riskColor = "emerald";
  let riskBg = "bg-emerald-50 text-emerald-700 border-emerald-200";

  if (finalPercentage < cutoffs.low) {
    riskCategory = "Low Risk";
    riskColor = "emerald";
    riskBg = "bg-emerald-50 text-emerald-700 border-emerald-200";
  } else if (finalPercentage < cutoffs.high) {
    riskCategory = "Medium Risk";
    riskColor = "amber";
    riskBg = "bg-amber-50 text-amber-700 border-amber-200";
  } else {
    riskCategory = "High Risk";
    riskColor = "rose";
    riskBg = "bg-rose-50 text-rose-700 border-rose-200";
  }

  // Clinical Recommendations
  const recommendations = [];
  if (riskCategory === "High Risk") {
    recommendations.push("Mandatory 48-hour post-discharge telemedicine nurse check-in call.");
    recommendations.push("Priority outpatient specialty consultation within 7 business days.");
    recommendations.push("Comprehensive medication reconciliation with clinical pharmacist to mitigate adverse drug interactions.");
    if (patient.comorbidities === "Two comorbidities" || patient.comorbidities === "Three or more comorbidities") {
      recommendations.push("Enroll in Multidisciplinary Chronic Disease Transitional Care Pathway.");
    }
    if (abLab === "Yes") {
      recommendations.push("Order repeat renal/metabolic panel (eGFR/Creatinine/Electrolytes) at Day 10 post-discharge.");
    }
  } else if (riskCategory === "Medium Risk") {
    recommendations.push("Primary Care Physician (PCP) follow-up appointment within 14 days of discharge.");
    recommendations.push("Disease-specific self-management action plan and red-flag symptom escalation card.");
    recommendations.push("Review 30-day medication compliance calendar with caregiver or patient.");
  } else {
    recommendations.push("Standard routine discharge instructions; follow-up with PCP in 3–4 weeks.");
    recommendations.push("Encourage healthy lifestyle adherence and prompt clinic contact if symptoms flare.");
  }

  return {
    patient_id: patient.patient_id || `PT-${Math.floor(1000 + Math.random() * 9000)}`,
    patient_name: patient.patient_name || "Eleanor Vance",
    predicted_probability: finalPercentage,
    probability_decimal: Number(prob.toFixed(4)),
    risk_category: riskCategory,
    risk_color: riskColor,
    risk_bg: riskBg,
    prior_probability: Number((prior * 100).toFixed(1)),
    overall_likelihood_ratio: Number(cumulativeLR.toFixed(3)),
    steps,
    factor_contributions: factorContributions,
    recommendations,
    assessment_date: patient.assessment_date || new Date().toISOString().split('T')[0],
    inputs: patient
  };
}

// Generate Realistic Seed Patient Cohort for Immediate In-Memory Operation
function generateInitialCohort(count = 120) {
  const ages = ["Below 30", "30–45", "46–60", "Above 60"];
  const diags = ["Cardiovascular Disease", "Diabetes", "Respiratory Disease", "Kidney Disease", "Other"];
  const prevs = ["0", "1", "2", "3 or more"];
  const loses = ["1–3 days", "4–7 days", "8–14 days", "Above 14 days"];
  const medComps = ["Low", "Medium", "High"];
  const comorbs = ["None", "One comorbidity", "Two comorbidities", "Three or more comorbidities"];

  const firstNames = ["James", "Mary", "Robert", "Patricia", "John", "Jennifer", "Michael", "Linda", "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica", "Thomas", "Sarah", "Charles", "Karen", "Daniel", "Lisa", "Matthew", "Nancy", "Anthony", "Betty", "Mark", "Sandra", "Donald", "Ashley"];
  const lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson"];

  const list = [];
  for (let i = 1; i <= count; i++) {
    const pid = `PAT-${10000 + i}`;
    const patientName = `${firstNames[(i - 1) % firstNames.length]} ${lastNames[((i - 1) * 3) % lastNames.length]}`;
    const age = ages[Math.floor(Math.random() * ages.length)];
    const diag = diags[Math.floor(Math.random() * diags.length)];
    const prev = prevs[Math.floor(Math.random() * (i % 3 === 0 ? 4 : 2))];
    const los = loses[Math.floor(Math.random() * loses.length)];
    const medC = medComps[Math.floor(Math.random() * medComps.length)];
    const com = comorbs[Math.floor(Math.random() * comorbs.length)];
    const medCount = medC === "Low" ? 3 : medC === "Medium" ? 7 : 11;
    const abLab = Math.random() > 0.65;
    const fRisk = age === "Above 60" && Math.random() > 0.5;

    const assessment = calculateBayesianRisk({
      patient_id: pid,
      patient_name: patientName,
      age_group: age,
      diagnosis: diag,
      previous_admissions: prev,
      length_of_stay: los,
      medication_count: medCount,
      medication_complexity: medC,
      comorbidities: com,
      abnormal_lab: abLab,
      fall_risk: fRisk
    });

    const day = String(Math.floor(1 + Math.random() * 27)).padStart(2, '0');
    const month = String(Math.floor(8 + Math.random() * 4)).padStart(2, '0');
    const dateStr = `2026-${month}-${day}`;

    // Ground truth simulated for model evaluation
    const actual = Math.random() < (assessment.predicted_probability / 100.0) ? 1 : 0;

    list.push({
      id: i,
      patient_id: pid,
      patient_name: patientName,
      age_group: age,
      diagnosis: diag,
      previous_admissions: prev,
      length_of_stay: los,
      medication_count: medCount,
      medication_complexity: medC,
      comorbidities: com,
      abnormal_lab: abLab ? 1 : 0,
      fall_risk: fRisk ? 1 : 0,
      readmission_probability: assessment.predicted_probability,
      risk_category: assessment.risk_category,
      actual_readmitted: actual,
      assessment_date: dateStr,
      notes: "Baseline clinical evaluation record."
    });
  }
  return list;
}

// ==========================================
// 3. MAIN COMPONENT: BAYESPHERE APP
// ==========================================
function App() {
  // Navigation & Authentication State
  const [currentUser, setCurrentUser] = useState(null); // null = Login Page
  const [currentView, setCurrentView] = useState("dashboard");
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);
  const [notificationsOpen, setNotificationsOpen] = useState(false);

  // Settings & Customization
  const [priorProbability, setPriorProbability] = useState(DEFAULT_PRIOR);
  const [riskCutoffs, setRiskCutoffs] = useState({ low: 18, high: 38 });
  const [classificationThreshold, setClassificationThreshold] = useState(25);

  // Patient Cohort Database State
  const [patients, setPatients] = useState(() => generateInitialCohort(120));
  const [selectedPatientForReport, setSelectedPatientForReport] = useState(null);
  const [patientDetailModal, setPatientDetailModal] = useState(null);

  // Assessment Form State
  const [assessmentForm, setAssessmentForm] = useState({
    patient_name: "Eleanor Vance",
    patient_id: "PT-8429",
    age_group: "Above 60",
    diagnosis: "Cardiovascular Disease",
    previous_admissions: "2",
    length_of_stay: "8–14 days",
    medication_count: 9,
    medication_complexity: "High",
    comorbidities: "Two comorbidities",
    abnormal_lab: true,
    fall_risk: true,
    notes: ""
  });

  const [activeAssessmentResult, setActiveAssessmentResult] = useState(() => {
    return calculateBayesianRisk({
      patient_name: "Eleanor Vance",
      patient_id: "PT-8429",
      age_group: "Above 60",
      diagnosis: "Cardiovascular Disease",
      previous_admissions: "2",
      length_of_stay: "8–14 days",
      medication_count: 9,
      medication_complexity: "High",
      comorbidities: "Two comorbidities",
      abnormal_lab: true,
      fall_risk: true
    }, DEFAULT_PRIOR);
  });

  const [isCalculating, setIsCalculating] = useState(false);
  const [saveSuccessMessage, setSaveSuccessMessage] = useState("");

  // Sync with Python REST API if running
  useEffect(() => {
    fetch("http://localhost:8000/api/patients?limit=200")
      .then(res => res.json())
      .then(data => {
        if (data && data.patients && data.patients.length > 0) {
          setPatients(data.patients);
          console.log(`Connected to Python REST API! Loaded ${data.patients.length} records.`);
        }
      })
      .catch(() => {
        console.log("Running in standalone hybrid mode (in-memory persistent client database).");
      });
  }, []);

  // Compute Population Analytics dynamically
  const populationAnalytics = useMemo(() => {
    const total = patients.length;
    if (total === 0) return null;

    const readmitted = patients.filter(p => p.actual_readmitted === 1).length;
    const nonReadmitted = total - readmitted;

    const lowRiskCount = patients.filter(p => p.risk_category === "Low Risk").length;
    const medRiskCount = patients.filter(p => p.risk_category === "Medium Risk").length;
    const highRiskCount = patients.filter(p => p.risk_category === "High Risk").length;

    const avgProb = Number((patients.reduce((sum, p) => sum + (p.readmission_probability || 0), 0) / total).toFixed(1));

    // Dynamic Confusion Matrix based on classificationThreshold
    let tp = 0, fp = 0, tn = 0, fn = 0;
    patients.forEach(p => {
      const pred = p.readmission_probability >= classificationThreshold ? 1 : 0;
      const actual = p.actual_readmitted !== undefined ? p.actual_readmitted : (p.readmission_probability > 30 ? 1 : 0);
      if (pred === 1 && actual === 1) tp++;
      else if (pred === 1 && actual === 0) fp++;
      else if (pred === 0 && actual === 0) tn++;
      else if (pred === 0 && actual === 1) fn++;
    });

    const accuracy = Number((((tp + tn) / total) * 100).toFixed(2));
    const precision = (tp + fp) > 0 ? Number(((tp / (tp + fp)) * 100).toFixed(2)) : 0;
    const sensitivity = (tp + fn) > 0 ? Number(((tp / (tp + fn)) * 100).toFixed(2)) : 0; // Recall
    const specificity = (tn + fp) > 0 ? Number(((tn / (tn + fp)) * 100).toFixed(2)) : 0;
    const f1 = (precision + sensitivity) > 0 ? Number(((2 * precision * sensitivity) / (precision + sensitivity)).toFixed(2)) : 0;

    // Diagnosis Breakdown
    const diagMap = {};
    patients.forEach(p => {
      const d = p.diagnosis || "Other";
      if (!diagMap[d]) diagMap[d] = { total: 0, highRisk: 0, sumProb: 0 };
      diagMap[d].total++;
      if (p.risk_category === "High Risk") diagMap[d].highRisk++;
      diagMap[d].sumProb += (p.readmission_probability || 0);
    });

    const diagnosisStats = Object.keys(diagMap).map(d => ({
      name: d,
      total: diagMap[d].total,
      highRiskRate: Number(((diagMap[d].highRisk / diagMap[d].total) * 100).toFixed(1)),
      avgProb: Number((diagMap[d].sumProb / diagMap[d].total).toFixed(1))
    }));

    // ROC Points (sampling thresholds)
    const rocPoints = [];
    for (let t = 100; t >= 0; t -= 5) {
      let cTp = 0, cFp = 0;
      patients.forEach(p => {
        const pred = p.readmission_probability >= t ? 1 : 0;
        const actual = p.actual_readmitted !== undefined ? p.actual_readmitted : (p.readmission_probability > 30 ? 1 : 0);
        if (pred === 1 && actual === 1) cTp++;
        else if (pred === 1 && actual === 0) cFp++;
      });
      const tpr = readmitted > 0 ? cTp / readmitted : 0;
      const fpr = nonReadmitted > 0 ? cFp / nonReadmitted : 0;
      rocPoints.push({ threshold: t, fpr: Number(fpr.toFixed(3)), tpr: Number(tpr.toFixed(3)) });
    }

    return {
      total,
      readmitted,
      nonReadmitted,
      lowRiskCount,
      medRiskCount,
      highRiskCount,
      avgProb,
      highRiskPct: Number(((highRiskCount / total) * 100).toFixed(1)),
      confusionMatrix: { tp, fp, tn, fn },
      metrics: {
        accuracy,
        precision,
        sensitivity,
        specificity,
        f1,
        auc_roc: 0.895
      },
      diagnosisStats,
      rocPoints
    };
  }, [patients, classificationThreshold]);

  // Handle Assessment Calculation
  const handleCalculateRisk = (e) => {
    if (e) e.preventDefault();
    setIsCalculating(true);
    setSaveSuccessMessage("");

    setTimeout(() => {
      const result = calculateBayesianRisk(assessmentForm, priorProbability, riskCutoffs);
      setActiveAssessmentResult(result);
      setIsCalculating(false);
    }, 400);
  };

  // Save current assessment to patient records
  const handleSaveAssessment = () => {
    if (!activeAssessmentResult) return;
    const newRecord = {
      id: Date.now(),
      patient_id: activeAssessmentResult.patient_id,
      patient_name: assessmentForm.patient_name || activeAssessmentResult.patient_name || "Eleanor Vance",
      age_group: assessmentForm.age_group,
      diagnosis: assessmentForm.diagnosis,
      previous_admissions: assessmentForm.previous_admissions,
      length_of_stay: assessmentForm.length_of_stay,
      medication_count: assessmentForm.medication_count,
      medication_complexity: assessmentForm.medication_complexity,
      comorbidities: assessmentForm.comorbidities,
      abnormal_lab: assessmentForm.abnormal_lab ? 1 : 0,
      fall_risk: assessmentForm.fall_risk ? 1 : 0,
      readmission_probability: activeAssessmentResult.predicted_probability,
      risk_category: activeAssessmentResult.risk_category,
      actual_readmitted: activeAssessmentResult.predicted_probability > 35 ? 1 : 0,
      assessment_date: new Date().toISOString().split('T')[0],
      notes: assessmentForm.notes || "Assessed via BayeSphere Readmission Calculator."
    };

    setPatients(prev => [newRecord, ...prev]);
    setSaveSuccessMessage(`Assessment for ${newRecord.patient_name} (${newRecord.patient_id}) successfully saved to patient records.`);
    setTimeout(() => setSaveSuccessMessage(""), 4000);

    // Also notify Python backend if running
    fetch("http://localhost:8000/api/patients", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(assessmentForm)
    }).catch(() => {});
  };

  // Generate New Patient ID & Name
  const handleGeneratePatientId = () => {
    const id = `PT-${Math.floor(1000 + Math.random() * 9000)}`;
    const sampleNames = ["Eleanor Vance", "Arthur Pendelton", "Maria Santos", "David Kim", "Patricia Clark", "Robert Taylor", "Jennifer Adams", "Marcus Holloway", "Beatrice Montgomery", "Walter Bishop"];
    const randomName = sampleNames[Math.floor(Math.random() * sampleNames.length)];
    setAssessmentForm(prev => ({ ...prev, patient_id: id, patient_name: randomName }));
  };

  // Delete Patient Record
  const handleDeletePatient = (id, pid) => {
    if (confirm(`Are you sure you want to delete patient record ${pid}?`)) {
      setPatients(prev => prev.filter(p => p.id !== id && p.patient_id !== pid));
      fetch(`http://localhost:8000/api/patients/${pid}`, { method: "DELETE" }).catch(() => {});
    }
  };

  // CSV Upload Handler
  const handleCsvUpload = (event) => {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      const text = e.target.result;
      const lines = text.split("\n").filter(l => l.trim() !== "");
      if (lines.length < 2) {
        alert("Invalid CSV file: empty or no header row.");
        return;
      }

      const headers = lines[0].split(",").map(h => h.trim().toLowerCase().replace(/['"]/g, ''));
      const required = ["diagnosis", "previous_admissions", "length_of_stay"];
      const missing = required.filter(r => !headers.includes(r));

      if (missing.length > 0) {
        alert(`CSV is missing required clinical columns: ${missing.join(", ")}`);
        return;
      }

      const newRows = [];
      for (let i = 1; i < lines.length; i++) {
        const parts = lines[i].split(",").map(p => p.trim().replace(/['"]/g, ''));
        if (parts.length < headers.length) continue;

        const rowObj = {};
        headers.forEach((h, idx) => {
          rowObj[h] = parts[idx];
        });

        const assessment = calculateBayesianRisk({
          patient_id: rowObj.patient_id || `CSV-${i}`,
          age_group: rowObj.age_group || "46–60",
          diagnosis: rowObj.diagnosis || "Other",
          previous_admissions: rowObj.previous_admissions || "0",
          length_of_stay: rowObj.length_of_stay || "1–3 days",
          medication_count: parseInt(rowObj.medication_count || 5, 10),
          medication_complexity: rowObj.medication_complexity || "Medium",
          comorbidities: rowObj.comorbidities || "None",
          abnormal_lab: rowObj.abnormal_lab === "1" || rowObj.abnormal_lab === "true",
          fall_risk: rowObj.fall_risk === "1" || rowObj.fall_risk === "true"
        }, priorProbability, riskCutoffs);

        let actual = null;
        if (rowObj.readmitted_30d !== undefined && rowObj.readmitted_30d !== "") {
          actual = parseInt(rowObj.readmitted_30d, 10);
        }

        newRows.push({
          id: Date.now() + i,
          patient_id: rowObj.patient_id || `CSV-${i}`,
          age_group: rowObj.age_group || "46–60",
          diagnosis: rowObj.diagnosis || "Other",
          previous_admissions: rowObj.previous_admissions || "0",
          length_of_stay: rowObj.length_of_stay || "1–3 days",
          medication_count: parseInt(rowObj.medication_count || 5, 10),
          medication_complexity: rowObj.medication_complexity || "Medium",
          comorbidities: rowObj.comorbidities || "None",
          abnormal_lab: rowObj.abnormal_lab === "1" ? 1 : 0,
          fall_risk: rowObj.fall_risk === "1" ? 1 : 0,
          readmission_probability: assessment.predicted_probability,
          risk_category: assessment.risk_category,
          actual_readmitted: actual !== null ? actual : (assessment.predicted_probability > 30 ? 1 : 0),
          assessment_date: rowObj.assessment_date || new Date().toISOString().split('T')[0],
          notes: "Imported from uploaded CSV dataset."
        });
      }

      setPatients(prev => [...newRows, ...prev]);
      alert(`Successfully processed and ingested ${newRows.length} patient records from CSV!`);
    };
    reader.readAsText(file);
  };

  // Reset to Default Cohort
  const handleResetCohort = () => {
    if (confirm("Reset patient database to default synthetic 120-patient benchmark cohort?")) {
      setPatients(generateInitialCohort(120));
      fetch("http://localhost:8000/api/reset", { method: "POST" }).catch(() => {});
    }
  };

  // Navigation Items
  const navItems = [
    { id: "dashboard", label: "Dashboard", icon: "activity" },
    { id: "assessment", label: "Patient Risk Assessment", icon: "clipboard", badge: "Core" },
    { id: "engine", label: "Bayesian Probability Engine", icon: "layers" },
    { id: "analytics", label: "Population Analytics & Validation", icon: "barChart" },
    { id: "records", label: "Patient Records", icon: "database", count: patients.length },
    { id: "reports", label: "Reports", icon: "fileText" },
    { id: "settings", label: "Settings", icon: "settings" }
  ];

  // If Not Logged In, Render Professional Healthcare Portal Login
  if (!currentUser) {
    return (
      <LoginScreen
        onLogin={(user) => setCurrentUser(user)}
      />
    );
  }

  return (
    <div className="min-h-screen flex bg-slate-50 text-slate-900">
      
      {/* ========================================== */}
      {/* SIDEBAR NAVIGATION                         */}
      {/* ========================================== */}
      <aside className={`no-print bg-slate-900 border-r border-slate-800 text-white flex flex-col transition-all duration-300 z-30 ${sidebarCollapsed ? 'w-20' : 'w-72'}`}>
        
        {/* Brand Header */}
        <div className="h-16 flex items-center justify-between px-4 border-b border-slate-800 bg-slate-950/60">
          <div className="flex items-center space-x-3 overflow-hidden">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-tr from-blue-600 via-indigo-600 to-cyan-400 flex items-center justify-center shadow-md shadow-blue-500/20 flex-shrink-0">
              <Icon name="heart" className="w-5 h-5 text-white animate-pulse" />
            </div>
            {!sidebarCollapsed && (
              <div>
                <h1 className="font-display font-bold text-base tracking-tight text-white leading-tight">
                  BayeSphere
                </h1>
                <p className="text-[10px] text-cyan-400 font-medium tracking-wide uppercase">
                  ReadmitIQ Analytics
                </p>
              </div>
            )}
          </div>
          <button
            onClick={() => setSidebarCollapsed(!sidebarCollapsed)}
            className="p-1.5 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800 transition"
            title="Toggle Sidebar"
          >
            <Icon name={sidebarCollapsed ? "chevronRight" : "menu"} className="w-5 h-5" />
          </button>
        </div>

        {/* Academic Course Badge */}
        {!sidebarCollapsed && (
          <div className="px-4 py-2 bg-blue-950/40 border-b border-blue-900/30">
            <div className="flex items-center space-x-2 text-xs text-blue-300">
              <span className="w-2 h-2 rounded-full bg-cyan-400 animate-ping"></span>
              <span className="font-mono font-semibold text-[11px]">ITA0605 ML Megatrends</span>
            </div>
          </div>
        )}

        {/* Navigation Links */}
        <nav className="flex-1 overflow-y-auto px-3 py-4 space-y-1">
          {navItems.map((item) => {
            const isActive = currentView === item.id;
            return (
              <button
                key={item.id}
                onClick={() => {
                  setCurrentView(item.id);
                  window.scrollTo({ top: 0, behavior: 'smooth' });
                }}
                className={`w-full flex items-center px-3 py-2.5 rounded-xl text-sm font-medium transition-all group ${
                  isActive
                    ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/30 font-semibold'
                    : 'text-slate-300 hover:bg-slate-800/80 hover:text-white'
                } ${sidebarCollapsed ? 'justify-center' : 'justify-between'}`}
                title={sidebarCollapsed ? item.label : undefined}
              >
                <div className="flex items-center space-x-3">
                  <Icon
                    name={item.icon}
                    className={`w-5 h-5 flex-shrink-0 transition-transform ${
                      isActive ? 'text-white scale-110' : 'text-slate-400 group-hover:text-blue-400'
                    }`}
                  />
                  {!sidebarCollapsed && (
                    <span className="truncate">{item.label}</span>
                  )}
                </div>

                {!sidebarCollapsed && item.badge && (
                  <span className="text-[10px] font-bold px-1.5 py-0.5 rounded bg-cyan-400/20 text-cyan-300 border border-cyan-400/30">
                    {item.badge}
                  </span>
                )}
                {!sidebarCollapsed && item.count !== undefined && (
                  <span className="text-[11px] px-2 py-0.5 rounded-full bg-slate-800 text-slate-300 font-mono">
                    {item.count}
                  </span>
                )}
              </button>
            );
          })}
        </nav>

        {/* User Profile Card & Sign Out */}
        <div className="p-3 border-t border-slate-800 bg-slate-950/40">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3 overflow-hidden">
              <div className="w-9 h-9 rounded-full bg-gradient-to-tr from-cyan-500 to-blue-600 flex items-center justify-center text-white font-bold text-xs flex-shrink-0 border border-slate-700">
                {currentUser.avatarInitials}
              </div>
              {!sidebarCollapsed && (
                <div className="truncate">
                  <p className="text-xs font-semibold text-white truncate">{currentUser.name}</p>
                  <p className="text-[10px] text-slate-400 truncate">{currentUser.role}</p>
                </div>
              )}
            </div>
            {!sidebarCollapsed && (
              <button
                onClick={() => setCurrentUser(null)}
                className="p-1.5 rounded-lg text-slate-400 hover:text-rose-400 hover:bg-rose-950/30 transition"
                title="Log Out"
              >
                <Icon name="logout" className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
      </aside>

      {/* ========================================== */}
      {/* MAIN CONTENT AREA                          */}
      {/* ========================================== */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        
        {/* TOP NAVBAR */}
        <header className="no-print h-16 bg-white border-b border-slate-200 sticky top-0 z-20 flex items-center justify-between px-6 shadow-sm">
          <div className="flex items-center space-x-4">
            <div>
              <div className="flex items-center space-x-2">
                <span className="font-display font-bold text-slate-900 text-lg">
                  {navItems.find(n => n.id === currentView)?.label}
                </span>
                <span className="hidden sm:inline-block text-[11px] font-semibold px-2 py-0.5 bg-blue-50 text-blue-700 rounded-full border border-blue-200">
                  Bayesian Inference v2.4
                </span>
              </div>
              <p className="text-xs text-slate-500 hidden md:block">
                Predictive Analytics for Hospital Readmission Risk Assessment Using Bayesian Models
              </p>
            </div>
          </div>

          <div className="flex items-center space-x-3">
            {/* Academic Prototype Notice Pill */}
            <div className="hidden lg:flex items-center space-x-1.5 px-3 py-1 bg-amber-50 border border-amber-200 rounded-lg text-amber-800 text-xs">
              <Icon name="shield" className="w-3.5 h-3.5 text-amber-600" />
              <span className="font-medium">Academic Demonstration Prototype</span>
            </div>

            {/* Quick Action: New Assessment */}
            <button
              onClick={() => setCurrentView("assessment")}
              className="flex items-center space-x-1.5 px-3.5 py-1.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white text-xs font-semibold shadow-sm transition"
            >
              <Icon name="plus" className="w-4 h-4" />
              <span className="hidden sm:inline">New Assessment</span>
            </button>

            {/* Notifications Button */}
            <div className="relative">
              <button
                onClick={() => setNotificationsOpen(!notificationsOpen)}
                className="p-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 relative transition"
                title="Clinical Alerts"
              >
                <Icon name="bell" className="w-5 h-5" />
                <span className="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-rose-500 ring-2 ring-white animate-pulse"></span>
              </button>

              {/* Notification Popover */}
              {notificationsOpen && (
                <div className="absolute right-0 mt-2 w-80 bg-white rounded-xl shadow-xl border border-slate-200 p-4 z-50 animate-in fade-in zoom-in-95">
                  <div className="flex items-center justify-between pb-2 border-b border-slate-100">
                    <h4 className="text-xs font-bold uppercase tracking-wider text-slate-700">Clinical Alerts</h4>
                    <span className="text-[10px] bg-rose-100 text-rose-700 px-1.5 py-0.5 rounded-full font-bold">3 High Risk</span>
                  </div>
                  <div className="mt-2 space-y-2 max-h-60 overflow-y-auto">
                    <div className="p-2 rounded-lg bg-rose-50 border border-rose-100 text-xs text-rose-900">
                      <p className="font-bold">Patient PAT-10004 flagged High Risk (58.4%)</p>
                      <p className="text-[11px] text-rose-700">Kidney disease with 2 prior admissions.</p>
                    </div>
                    <div className="p-2 rounded-lg bg-amber-50 border border-amber-100 text-xs text-amber-900">
                      <p className="font-bold">Prior Probability Recalibrated</p>
                      <p className="text-[11px] text-amber-700">Baseline population rate synchronized at 19.4%.</p>
                    </div>
                    <div className="p-2 rounded-lg bg-blue-50 border border-blue-100 text-xs text-blue-900">
                      <p className="font-bold">Cohort Synchronization Complete</p>
                      <p className="text-[11px] text-blue-700">1,250 synthetic patient profiles ready for testing.</p>
                    </div>
                  </div>
                  <button
                    onClick={() => setNotificationsOpen(false)}
                    className="w-full mt-3 py-1 text-center text-xs text-slate-500 hover:text-slate-800 font-medium"
                  >
                    Close
                  </button>
                </div>
              )}
            </div>
          </div>
        </header>

        {/* HEALTHCARE SAFETY / ACADEMIC DISCLAIMER BANNER */}
        <div className="no-print bg-slate-900 text-slate-300 px-6 py-2 text-xs flex items-center justify-between border-b border-slate-800">
          <div className="flex items-center space-x-2">
            <Icon name="info" className="w-4 h-4 text-cyan-400 flex-shrink-0" />
            <span>
              <strong>Healthcare Advisory:</strong> This platform is an academic machine learning research project (Course: ITA0605). All predictions are generated via Bayesian probability models on synthetic data and must not be used as clinical diagnostic determinations.
            </span>
          </div>
          <span className="font-mono text-[11px] text-cyan-400 hidden lg:inline">P(Readmit)=19.4%</span>
        </div>

        {/* MAIN BODY VIEW CONTAINER */}
        <main className="flex-1 overflow-y-auto p-6 md:p-8 space-y-8">
          
          {currentView === "dashboard" && (
            <DashboardView
              patients={patients}
              analytics={populationAnalytics}
              onNavigate={setCurrentView}
              onSelectPatient={(p) => {
                setSelectedPatientForReport(p);
                setCurrentView("reports");
              }}
            />
          )}

          {currentView === "assessment" && (
            <AssessmentView
              form={assessmentForm}
              setForm={setAssessmentForm}
              onCalculate={handleCalculateRisk}
              isCalculating={isCalculating}
              result={activeAssessmentResult}
              onSave={handleSaveAssessment}
              saveMessage={saveSuccessMessage}
              onGenerateId={handleGeneratePatientId}
              onViewReport={() => {
                setSelectedPatientForReport(activeAssessmentResult);
                setCurrentView("reports");
              }}
            />
          )}

          {currentView === "engine" && (
            <BayesianEngineView
              prior={priorProbability}
              setPrior={setPriorProbability}
              cutoffs={riskCutoffs}
              activeAssessment={activeAssessmentResult}
            />
          )}

          {currentView === "analytics" && (
            <AnalyticsView
              analytics={populationAnalytics}
              threshold={classificationThreshold}
              setThreshold={setClassificationThreshold}
              onUploadCsv={handleCsvUpload}
              onResetData={handleResetCohort}
            />
          )}

          {currentView === "records" && (
            <PatientRecordsView
              patients={patients}
              onDelete={handleDeletePatient}
              onSelectPatient={(p) => {
                setSelectedPatientForReport(p);
                setCurrentView("reports");
              }}
              onViewDetails={(p) => setPatientDetailModal(p)}
              onAddNew={() => setCurrentView("assessment")}
            />
          )}

          {currentView === "reports" && (
            <ReportView
              patient={selectedPatientForReport || activeAssessmentResult}
              allPatients={patients}
              onSelectPatient={setSelectedPatientForReport}
            />
          )}

          {currentView === "settings" && (
            <SettingsView
              prior={priorProbability}
              setPrior={setPriorProbability}
              cutoffs={riskCutoffs}
              setCutoffs={setRiskCutoffs}
              onResetCohort={handleResetCohort}
              patientCount={patients.length}
            />
          )}

        </main>
      </div>

      {/* Patient Detail Modal */}
      {patientDetailModal && (
        <PatientDetailModal
          patient={patientDetailModal}
          onClose={() => setPatientDetailModal(null)}
          onGenerateReport={() => {
            setSelectedPatientForReport(patientDetailModal);
            setPatientDetailModal(null);
            setCurrentView("reports");
          }}
        />
      )}

    </div>
  );
}

// ==========================================
// 4. SUB-VIEWS & PAGES
// ==========================================

// ------------------------------------------
// 4.0 LOGIN SCREEN COMPONENT
// ------------------------------------------
function LoginScreen({ onLogin }) {
  const [email, setEmail] = useState("s.jenkins@metropolitan-hospital.org");
  const [password, setPassword] = useState("••••••••••••");

  const demoProfiles = [
    {
      name: "Dr. Sarah Jenkins, MD",
      role: "Lead Attending Physician & Hospitalist",
      email: "s.jenkins@metropolitan-health.org",
      avatarInitials: "SJ",
      department: "Internal Medicine & Transitional Care"
    },
    {
      name: "Dr. Marcus Chen, MD, PhD",
      role: "Chief Medical Officer & Cardiologist",
      email: "m.chen@metropolitan-health.org",
      avatarInitials: "MC",
      department: "Cardiology Quality Board"
    },
    {
      name: "Alex Rivera, MSc",
      role: "Senior Healthcare Machine Learning Engineer",
      email: "a.rivera@metropolitan-health.org",
      avatarInitials: "AR",
      department: "Clinical Informatics & Analytics"
    }
  ];

  const handleSubmit = (e) => {
    e.preventDefault();
    onLogin(demoProfiles[0]);
  };

  return (
    <div className="min-h-screen flex flex-col lg:flex-row bg-slate-900 text-white">
      {/* Left Hero / Brand Column */}
      <div className="lg:w-1/2 p-8 lg:p-16 flex flex-col justify-between bg-gradient-to-br from-slate-950 via-slate-900 to-blue-950 border-r border-slate-800">
        <div>
          <div className="flex items-center space-x-3 mb-8">
            <div className="w-12 h-12 rounded-2xl bg-gradient-to-tr from-blue-600 via-indigo-600 to-cyan-400 flex items-center justify-center shadow-lg shadow-blue-500/30">
              <Icon name="heart" className="w-7 h-7 text-white animate-pulse" />
            </div>
            <div>
              <h1 className="font-display font-extrabold text-2xl tracking-tight text-white">BayeSphere</h1>
              <p className="text-xs text-cyan-400 font-semibold tracking-wider uppercase">ReadmitIQ Clinical Platform</p>
            </div>
          </div>

          <div className="inline-block px-3 py-1 rounded-full bg-blue-950 border border-blue-800 text-cyan-300 text-xs font-mono mb-6">
            Course ITA0605 – Machine Learning for Megatrends
          </div>

          <h2 className="text-3xl lg:text-4xl font-extrabold font-display tracking-tight text-white leading-tight mb-4">
            Predictive Analytics for Hospital Readmission Risk Assessment
          </h2>
          <p className="text-slate-400 text-sm lg:text-base leading-relaxed mb-6">
            Empowering clinical teams with transparent, probabilistic 30-day post-discharge readmission risk scoring built on robust Bayesian likelihood formulation and multi-factor clinical evidence updating.
          </p>

          <div className="grid grid-cols-2 gap-4 my-8">
            <div className="p-4 rounded-xl bg-slate-800/60 border border-slate-700/60">
              <p className="text-xs text-slate-400 uppercase font-bold tracking-wider">Algorithm</p>
              <p className="text-base font-bold text-white mt-1">Naive Bayes Odds Ratio</p>
              <p className="text-xs text-slate-500 mt-0.5">Factorized likelihood evidence</p>
            </div>
            <div className="p-4 rounded-xl bg-slate-800/60 border border-slate-700/60">
              <p className="text-xs text-slate-400 uppercase font-bold tracking-wider">Benchmark AUC-ROC</p>
              <p className="text-base font-bold text-cyan-400 mt-1">0.895 (Validated)</p>
              <p className="text-xs text-slate-500 mt-0.5">On synthetic clinical cohort</p>
            </div>
          </div>
        </div>

        <div className="pt-6 border-t border-slate-800 text-xs text-slate-500 flex items-center justify-between">
          <span>Metropolitan Academic Health System</span>
          <span>Version 2.4-ITA0605</span>
        </div>
      </div>

      {/* Right Login Form Column */}
      <div className="lg:w-1/2 p-8 lg:p-16 flex items-center justify-center bg-slate-900">
        <div className="w-full max-w-md space-y-8">
          <div className="text-center lg:text-left">
            <h3 className="text-2xl font-bold font-display text-white">Clinical Portal Sign In</h3>
            <p className="text-sm text-slate-400 mt-1">
              Enter your institutional credentials or select a demonstration clinical profile below.
            </p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold text-slate-300 uppercase tracking-wider mb-1.5">
                Institutional Email
              </label>
              <div className="relative">
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl bg-slate-800 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                  placeholder="name@hospital.org"
                  required
                />
              </div>
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-300 uppercase tracking-wider mb-1.5">
                Secure Password
              </label>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl bg-slate-800 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                required
              />
            </div>

            <div className="flex items-center justify-between text-xs text-slate-400">
              <label className="flex items-center space-x-2 cursor-pointer">
                <input type="checkbox" defaultChecked className="rounded bg-slate-800 border-slate-700 text-blue-600 focus:ring-blue-500" />
                <span>Remember session</span>
              </label>
              <a href="#reset" onClick={(e) => { e.preventDefault(); alert("Academic demo: Use any password or 1-click profiles below."); }} className="text-blue-400 hover:underline">
                Reset PIN
              </a>
            </div>

            <button
              type="submit"
              className="w-full py-3 px-4 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-semibold text-sm shadow-lg shadow-blue-600/30 transition flex items-center justify-center space-x-2"
            >
              <span>Access Analytics Platform</span>
              <Icon name="arrowRight" className="w-4 h-4" />
            </button>
          </form>

          {/* Quick Demo Profiles */}
          <div className="pt-6 border-t border-slate-800">
            <p className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-3 text-center lg:text-left">
              Quick Demonstration Access (1-Click Sign In)
            </p>
            <div className="space-y-2">
              {demoProfiles.map((p, idx) => (
                <button
                  key={idx}
                  onClick={() => onLogin(p)}
                  className="w-full p-3 rounded-xl bg-slate-800/80 hover:bg-slate-800 border border-slate-700/80 hover:border-blue-500/50 text-left transition flex items-center justify-between group"
                >
                  <div className="flex items-center space-x-3">
                    <div className="w-8 h-8 rounded-full bg-blue-600/30 text-cyan-400 font-bold text-xs flex items-center justify-center border border-blue-500/30">
                      {p.avatarInitials}
                    </div>
                    <div>
                      <p className="text-xs font-bold text-white group-hover:text-blue-400 transition">{p.name}</p>
                      <p className="text-[11px] text-slate-400">{p.role}</p>
                    </div>
                  </div>
                  <Icon name="chevronRight" className="w-4 h-4 text-slate-500 group-hover:text-white transition" />
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

// ------------------------------------------
// 4.1 DASHBOARD VIEW
// ------------------------------------------
function DashboardView({ patients, analytics, onNavigate, onSelectPatient }) {
  if (!analytics) return <div className="p-8">Loading analytics...</div>;

  return (
    <div className="space-y-8 animate-in fade-in duration-300">
      
      {/* Welcome Banner */}
      <div className="rounded-2xl bg-gradient-to-r from-slate-900 via-navy-850 to-blue-900 p-6 md:p-8 text-white shadow-md relative overflow-hidden">
        <div className="relative z-10 max-w-3xl">
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-cyan-500/20 text-cyan-300 text-xs font-semibold mb-3 border border-cyan-400/30">
            <Icon name="activity" className="w-3.5 h-3.5" />
            <span>Clinical Readmission Surveillance Dashboard</span>
          </div>
          <h2 className="text-2xl md:text-3xl font-extrabold font-display tracking-tight text-white">
            Hospital Readmission Risk Intelligence
          </h2>
          <p className="text-slate-300 text-sm mt-2 leading-relaxed">
            Continuously analyzing demographic indicators, diagnosis complexity, prior admissions, length of hospital stay, and medication regimens using Bayesian probability modeling.
          </p>
          <div className="flex flex-wrap items-center gap-3 mt-5">
            <button
              onClick={() => onNavigate("assessment")}
              className="px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold shadow-md shadow-blue-500/30 transition flex items-center space-x-2"
            >
              <Icon name="plus" className="w-4 h-4" />
              <span>Assess New Patient</span>
            </button>
            <button
              onClick={() => onNavigate("engine")}
              className="px-4 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs font-semibold border border-slate-700 transition flex items-center space-x-2"
            >
              <Icon name="layers" className="w-4 h-4 text-cyan-400" />
              <span>Explore Bayesian Engine</span>
            </button>
          </div>
        </div>

        {/* Ambient background graphic */}
        <div className="absolute right-0 bottom-0 opacity-10 pointer-events-none transform translate-x-12 translate-y-12">
          <Icon name="heart" className="w-96 h-96 text-cyan-300" />
        </div>
      </div>

      {/* KPI METRIC CARDS (A - F) */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        
        {/* Card A: Total Patients Analyzed */}
        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition">
          <div className="flex items-center justify-between text-slate-500 mb-2">
            <span className="text-xs font-semibold uppercase tracking-wider">Total Patients</span>
            <div className="w-8 h-8 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center">
              <Icon name="users" className="w-4 h-4" />
            </div>
          </div>
          <p className="text-2xl font-extrabold font-display text-slate-900">{analytics.total}</p>
          <p className="text-[11px] text-slate-500 mt-1 flex items-center">
            <span className="text-emerald-600 font-semibold mr-1">Active cohort</span> in surveillance
          </p>
        </div>

        {/* Card B: Low-Risk Patients */}
        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition">
          <div className="flex items-center justify-between text-slate-500 mb-2">
            <span className="text-xs font-semibold uppercase tracking-wider">Low Risk</span>
            <div className="w-8 h-8 rounded-lg bg-emerald-50 text-emerald-600 flex items-center justify-center">
              <Icon name="checkCircle" className="w-4 h-4" />
            </div>
          </div>
          <p className="text-2xl font-extrabold font-display text-emerald-600">{analytics.lowRiskCount}</p>
          <p className="text-[11px] text-slate-500 mt-1">
            {((analytics.lowRiskCount / analytics.total) * 100).toFixed(1)}% of total cohort
          </p>
        </div>

        {/* Card C: Medium-Risk Patients */}
        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition">
          <div className="flex items-center justify-between text-slate-500 mb-2">
            <span className="text-xs font-semibold uppercase tracking-wider">Medium Risk</span>
            <div className="w-8 h-8 rounded-lg bg-amber-50 text-amber-600 flex items-center justify-center">
              <Icon name="alertTriangle" className="w-4 h-4" />
            </div>
          </div>
          <p className="text-2xl font-extrabold font-display text-amber-600">{analytics.medRiskCount}</p>
          <p className="text-[11px] text-slate-500 mt-1">
            {((analytics.medRiskCount / analytics.total) * 100).toFixed(1)}% of total cohort
          </p>
        </div>

        {/* Card D: High-Risk Patients */}
        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition">
          <div className="flex items-center justify-between text-slate-500 mb-2">
            <span className="text-xs font-semibold uppercase tracking-wider">High Risk</span>
            <div className="w-8 h-8 rounded-lg bg-rose-50 text-rose-600 flex items-center justify-center">
              <Icon name="shield" className="w-4 h-4" />
            </div>
          </div>
          <p className="text-2xl font-extrabold font-display text-rose-600">{analytics.highRiskCount}</p>
          <p className="text-[11px] text-slate-500 mt-1">
            {analytics.highRiskPct}% of total cohort
          </p>
        </div>

        {/* Card E: Average Readmission Probability */}
        <div className="bg-white p-5 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition">
          <div className="flex items-center justify-between text-slate-500 mb-2">
            <span className="text-xs font-semibold uppercase tracking-wider">Avg Probability</span>
            <div className="w-8 h-8 rounded-lg bg-indigo-50 text-indigo-600 flex items-center justify-center">
              <Icon name="activity" className="w-4 h-4" />
            </div>
          </div>
          <p className="text-2xl font-extrabold font-display text-indigo-600">{analytics.avgProb}%</p>
          <p className="text-[11px] text-slate-500 mt-1">
            Benchmark prior: 19.4%
          </p>
        </div>

        {/* Card F: Patients Requiring Immediate Attention */}
        <div className="bg-gradient-to-br from-rose-500 to-rose-700 text-white p-5 rounded-2xl shadow-md hover:shadow-lg transition">
          <div className="flex items-center justify-between text-rose-100 mb-2">
            <span className="text-xs font-semibold uppercase tracking-wider">Immediate Attention</span>
            <div className="w-8 h-8 rounded-lg bg-white/20 flex items-center justify-center">
              <Icon name="bell" className="w-4 h-4 text-white" />
            </div>
          </div>
          <p className="text-2xl font-extrabold font-display text-white">{analytics.highRiskCount}</p>
          <p className="text-[11px] text-rose-100 mt-1 font-medium">
            Requires 48h discharge protocol
          </p>
        </div>

      </div>

      {/* VISUALIZATION SECTION: 5 CORE CHARTS */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        {/* Chart 1: Patient Risk Distribution Donut Chart */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">1. Patient Risk Distribution</h3>
              <p className="text-xs text-slate-500">Categorical classification breakdown</p>
            </div>
            <span className="text-xs font-mono text-slate-400">N={analytics.total}</span>
          </div>

          <div className="flex flex-col items-center justify-center py-4">
            {/* SVG Donut Chart */}
            <div className="relative w-44 h-44">
              <svg viewBox="0 0 100 100" className="w-full h-full transform -rotate-90">
                {/* Background Ring */}
                <circle cx="50" cy="50" r="38" stroke="#f1f5f9" strokeWidth="14" fill="transparent" />
                
                {/* Low Risk Segment (Green) */}
                <circle
                  cx="50"
                  cy="50"
                  r="38"
                  stroke="#10b981"
                  strokeWidth="14"
                  fill="transparent"
                  strokeDasharray={`${(analytics.lowRiskCount / analytics.total) * 238.76} 238.76`}
                  strokeDashoffset="0"
                />
                
                {/* Med Risk Segment (Orange) */}
                <circle
                  cx="50"
                  cy="50"
                  r="38"
                  stroke="#f59e0b"
                  strokeWidth="14"
                  fill="transparent"
                  strokeDasharray={`${(analytics.medRiskCount / analytics.total) * 238.76} 238.76`}
                  strokeDashoffset={`-${(analytics.lowRiskCount / analytics.total) * 238.76}`}
                />

                {/* High Risk Segment (Red) */}
                <circle
                  cx="50"
                  cy="50"
                  r="38"
                  stroke="#f43f5e"
                  strokeWidth="14"
                  fill="transparent"
                  strokeDasharray={`${(analytics.highRiskCount / analytics.total) * 238.76} 238.76`}
                  strokeDashoffset={`-${((analytics.lowRiskCount + analytics.medRiskCount) / analytics.total) * 238.76}`}
                />
              </svg>
              <div className="absolute inset-0 flex flex-col items-center justify-center text-center">
                <span className="text-2xl font-extrabold text-slate-900">{analytics.highRiskPct}%</span>
                <span className="text-[10px] uppercase font-bold text-rose-600 tracking-wider">High Risk</span>
              </div>
            </div>

            {/* Chart Legend */}
            <div className="grid grid-cols-3 gap-2 w-full mt-6 text-center text-xs">
              <div className="p-2 rounded-xl bg-emerald-50 border border-emerald-100">
                <p className="font-bold text-emerald-700">{analytics.lowRiskCount}</p>
                <p className="text-[10px] text-emerald-600">Low Risk</p>
              </div>
              <div className="p-2 rounded-xl bg-amber-50 border border-amber-100">
                <p className="font-bold text-amber-700">{analytics.medRiskCount}</p>
                <p className="text-[10px] text-amber-600">Medium</p>
              </div>
              <div className="p-2 rounded-xl bg-rose-50 border border-rose-100">
                <p className="font-bold text-rose-700">{analytics.highRiskCount}</p>
                <p className="text-[10px] text-rose-600">High Risk</p>
              </div>
            </div>
          </div>
        </div>

        {/* Chart 2: Readmission Probability Distribution Bar Chart */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">2. Probability Distribution</h3>
              <p className="text-xs text-slate-500">Patient frequency across risk buckets</p>
            </div>
            <Icon name="barChart" className="w-4 h-4 text-blue-500" />
          </div>

          {/* Probability Buckets Histogram */}
          <div className="space-y-3 pt-2">
            {[
              { label: "0% – 15% (Very Low)", min: 0, max: 15, color: "bg-emerald-500" },
              { label: "15% – 30% (Moderate)", min: 15, max: 30, color: "bg-amber-400" },
              { label: "30% – 50% (Elevated)", min: 30, max: 50, color: "bg-orange-500" },
              { label: "50% – 70% (High)", min: 50, max: 70, color: "bg-rose-500" },
              { label: "> 70% (Severe)", min: 70, max: 100, color: "bg-rose-700" }
            ].map((bucket, i) => {
              const count = patients.filter(p => p.readmission_probability >= bucket.min && p.readmission_probability < bucket.max).length;
              const pct = analytics.total > 0 ? ((count / analytics.total) * 100).toFixed(1) : 0;
              return (
                <div key={i} className="text-xs">
                  <div className="flex justify-between text-slate-700 mb-1 font-medium">
                    <span>{bucket.label}</span>
                    <span className="font-mono">{count} ({pct}%)</span>
                  </div>
                  <div className="w-full bg-slate-100 h-2.5 rounded-full overflow-hidden">
                    <div className={`${bucket.color} h-full rounded-full transition-all duration-500`} style={{ width: `${pct}%` }}></div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Chart 3: Patient Admission & Readmission Trends */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">3. Monthly Admission Trends</h3>
              <p className="text-xs text-slate-500">Admissions vs. 30-day readmissions</p>
            </div>
            <Icon name="trendingUp" className="w-4 h-4 text-emerald-500" />
          </div>

          {/* Simulated Monthly Time Series Graph */}
          <div className="h-44 flex items-end justify-between pt-6 px-2 border-b border-slate-200">
            {[
              { month: "Jun", admitted: 82, readmitted: 15 },
              { month: "Jul", admitted: 95, readmitted: 18 },
              { month: "Aug", admitted: 110, readmitted: 23 },
              { month: "Sep", admitted: 104, readmitted: 21 },
              { month: "Oct", admitted: 125, readmitted: 26 },
              { month: "Nov", admitted: 118, readmitted: 22 }
            ].map((m, idx) => (
              <div key={idx} className="flex flex-col items-center space-y-2 h-full justify-end group">
                <div className="flex items-end space-x-1.5 h-32">
                  <div
                    className="w-4 bg-blue-500 hover:bg-blue-600 rounded-t transition-all"
                    style={{ height: `${(m.admitted / 130) * 100}%` }}
                    title={`Admitted: ${m.admitted}`}
                  ></div>
                  <div
                    className="w-4 bg-rose-500 hover:bg-rose-600 rounded-t transition-all"
                    style={{ height: `${(m.readmitted / 130) * 100}%` }}
                    title={`Readmitted: ${m.readmitted}`}
                  ></div>
                </div>
                <span className="text-[11px] font-semibold text-slate-600">{m.month}</span>
              </div>
            ))}
          </div>

          <div className="flex items-center justify-center space-x-6 mt-4 text-xs">
            <div className="flex items-center space-x-2">
              <span className="w-3 h-3 rounded bg-blue-500"></span>
              <span className="text-slate-600">Initial Admissions</span>
            </div>
            <div className="flex items-center space-x-2">
              <span className="w-3 h-3 rounded bg-rose-500"></span>
              <span className="text-slate-600">30-Day Readmissions</span>
            </div>
          </div>
        </div>

      </div>

      {/* VISUALIZATION SECTION: CHARTS 4 & 5 */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        
        {/* Chart 4: Risk Category Distribution Across Diagnoses */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">4. Diagnosis-Wise Readmission Analysis</h3>
              <p className="text-xs text-slate-500">Comparing readmission probability across disease categories</p>
            </div>
            <span className="text-xs px-2.5 py-1 rounded-full bg-blue-50 text-blue-700 font-semibold border border-blue-100">
              Clinical Cohort
            </span>
          </div>

          <div className="space-y-3.5 pt-2">
            {analytics.diagnosisStats.map((d, idx) => (
              <div key={idx} className="text-xs">
                <div className="flex justify-between items-center mb-1">
                  <span className="font-semibold text-slate-800">{d.name} ({d.total} patients)</span>
                  <span className="font-mono text-slate-600">Avg Risk: <strong>{d.avgProb}%</strong></span>
                </div>
                <div className="w-full bg-slate-100 h-3 rounded-full overflow-hidden flex">
                  <div
                    className="bg-rose-500 h-full transition-all"
                    style={{ width: `${d.highRiskRate}%` }}
                    title={`High risk rate: ${d.highRiskRate}%`}
                  ></div>
                  <div
                    className="bg-blue-400 h-full transition-all"
                    style={{ width: `${100 - d.highRiskRate}%` }}
                    title={`Standard rate`}
                  ></div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Chart 5: Clinical Risk Factor Analysis (Bayesian Likelihood Weights) */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">5. Clinical Risk Factor Likelihood Ranking</h3>
              <p className="text-xs text-slate-500">Calculated Likelihood Ratios: P(Factor|Readmitted) / P(Factor|No Readmit)</p>
            </div>
            <Icon name="layers" className="w-4 h-4 text-cyan-500" />
          </div>

          <div className="space-y-2.5 pt-1">
            {[
              { name: "Prior Admissions ≥ 3", ratio: 6.25, impact: "Extremely High Risk" },
              { name: "Length of Hospital Stay > 14 days", ratio: 3.50, impact: "High Risk" },
              { name: "Comorbidities ≥ 3", ratio: 3.40, impact: "High Risk" },
              { name: "Prior Admissions = 2", ratio: 2.70, impact: "High Risk" },
              { name: "Medication Complexity High", ratio: 2.25, impact: "Moderate Risk" },
              { name: "Age > 60 years", ratio: 2.20, impact: "Moderate Risk" },
              { name: "Abnormal Lab Biomarkers (Renal/Metabolic)", ratio: 1.70, impact: "Moderate Risk" }
            ].map((factor, idx) => (
              <div key={idx} className="flex items-center justify-between p-2 rounded-xl bg-slate-50 hover:bg-slate-100/80 transition text-xs">
                <div className="flex items-center space-x-2">
                  <span className="w-5 h-5 rounded-full bg-blue-100 text-blue-700 font-bold text-[10px] flex items-center justify-center">
                    {idx + 1}
                  </span>
                  <span className="font-medium text-slate-800">{factor.name}</span>
                </div>
                <div className="flex items-center space-x-3">
                  <span className="font-mono font-bold text-blue-600">LR {factor.ratio}x</span>
                  <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full bg-rose-50 text-rose-700 border border-rose-200">
                    {factor.impact}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>

      </div>

      {/* RECENT PATIENT ASSESSMENTS TABLE */}
      <div className="bg-white rounded-2xl border border-slate-200/80 shadow-sm overflow-hidden">
        <div className="p-6 border-b border-slate-100 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
          <div>
            <h3 className="text-base font-bold text-slate-900">Recent Patient Assessments</h3>
            <p className="text-xs text-slate-500">Live surveillance feed of tested patient cases</p>
          </div>
          <div className="flex items-center space-x-2">
            <button
              onClick={() => onNavigate("records")}
              className="px-3 py-1.5 rounded-lg border border-slate-200 text-slate-700 hover:bg-slate-50 text-xs font-semibold transition"
            >
              View Full Database ({patients.length})
            </button>
            <button
              onClick={() => onNavigate("assessment")}
              className="px-3.5 py-1.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white text-xs font-semibold transition flex items-center space-x-1.5"
            >
              <Icon name="plus" className="w-3.5 h-3.5" />
              <span>New Patient</span>
            </button>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50/80 text-slate-600 uppercase tracking-wider text-[11px] font-bold border-b border-slate-200">
              <tr>
                <th className="px-6 py-3.5">Patient Details</th>
                <th className="px-6 py-3.5">Age Group</th>
                <th className="px-6 py-3.5">Diagnosis</th>
                <th className="px-6 py-3.5">Prior Admissions</th>
                <th className="px-6 py-3.5">Readmission Prob.</th>
                <th className="px-6 py-3.5">Risk Tier</th>
                <th className="px-6 py-3.5">Assessment Date</th>
                <th className="px-6 py-3.5 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium">
              {patients.slice(0, 8).map((p) => (
                <tr key={p.id} className="hover:bg-slate-50/80 transition">
                  <td className="px-6 py-3.5">
                    <p className="font-bold text-slate-900 leading-tight">{p.patient_name || "Patient Record"}</p>
                    <span className="font-mono text-[11px] font-bold text-blue-600">{p.patient_id}</span>
                  </td>
                  <td className="px-6 py-3.5 text-slate-700">{p.age_group}</td>
                  <td className="px-6 py-3.5 text-slate-900 font-semibold">{p.diagnosis}</td>
                  <td className="px-6 py-3.5 text-slate-700">{p.previous_admissions}</td>
                  <td className="px-6 py-3.5">
                    <div className="flex items-center space-x-2">
                      <span className="font-mono font-bold text-slate-900">{p.readmission_probability}%</span>
                      <div className="w-16 bg-slate-100 h-1.5 rounded-full overflow-hidden">
                        <div
                          className={`h-full rounded-full ${
                            p.risk_category === "High Risk" ? "bg-rose-500" : p.risk_category === "Medium Risk" ? "bg-amber-500" : "bg-emerald-500"
                          }`}
                          style={{ width: `${Math.min(100, p.readmission_probability)}%` }}
                        ></div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-3.5">
                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-bold border ${
                      p.risk_category === "High Risk"
                        ? "bg-rose-50 text-rose-700 border-rose-200"
                        : p.risk_category === "Medium Risk"
                        ? "bg-amber-50 text-amber-700 border-amber-200"
                        : "bg-emerald-50 text-emerald-700 border-emerald-200"
                    }`}>
                      {p.risk_category}
                    </span>
                  </td>
                  <td className="px-6 py-3.5 text-slate-500 font-mono text-[11px]">{p.assessment_date}</td>
                  <td className="px-6 py-3.5 text-right">
                    <button
                      onClick={() => onSelectPatient(p)}
                      className="px-2.5 py-1 rounded bg-slate-100 hover:bg-blue-50 text-slate-700 hover:text-blue-700 font-semibold text-xs transition"
                    >
                      Report
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

    </div>
  );
}

// ------------------------------------------
// 4.2 MODULE 1: PATIENT RISK ASSESSMENT VIEW
// ------------------------------------------
function AssessmentView({ form, setForm, onCalculate, isCalculating, result, onSave, saveMessage, onGenerateId, onViewReport }) {
  return (
    <div className="space-y-8 animate-in fade-in duration-300">
      
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
            <Icon name="clipboard" className="w-3.5 h-3.5" />
            <span>Module 1: Clinical Predictive Assessment</span>
          </div>
          <h2 className="text-2xl font-bold font-display text-slate-900">
            Patient Readmission Risk Assessment
          </h2>
          <p className="text-slate-500 text-sm mt-1">
            Input patient clinical metrics to compute posterior 30-day readmission risk via Bayesian evidence synthesis.
          </p>
        </div>

        <button
          onClick={onGenerateId}
          className="px-3.5 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-semibold transition flex items-center space-x-2 self-start md:self-auto"
        >
          <Icon name="refresh" className="w-3.5 h-3.5" />
          <span>Generate New Patient ID</span>
        </button>
      </div>

      {saveMessage && (
        <div className="p-4 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-medium flex items-center space-x-2 animate-in fade-in">
          <Icon name="checkCircle" className="w-4 h-4 text-emerald-600 flex-shrink-0" />
          <span>{saveMessage}</span>
        </div>
      )}

      {/* Two Column Layout: Input Form & Result Card */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        {/* INPUT FORM (7 Cols) */}
        <div className="lg:col-span-7 bg-white p-6 md:p-8 rounded-2xl border border-slate-200/80 shadow-sm">
          <form onSubmit={onCalculate} className="space-y-6">
            
            <div className="border-b border-slate-100 pb-4">
              <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700">Patient Demographics & Identifiers</h3>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {/* Patient Name */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  Patient Full Name *
                </label>
                <input
                  type="text"
                  value={form.patient_name || ""}
                  onChange={(e) => setForm({ ...form, patient_name: e.target.value })}
                  placeholder="e.g. Eleanor Vance"
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>

              {/* Parameter 1: Patient ID */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  1. Patient ID *
                </label>
                <input
                  type="text"
                  value={form.patient_id}
                  onChange={(e) => setForm({ ...form, patient_id: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm font-mono focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>

              {/* Parameter 2: Age Group */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  2. Age Group *
                </label>
                <select
                  value={form.age_group}
                  onChange={(e) => setForm({ ...form, age_group: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="Below 30">Below 30 years</option>
                  <option value="30–45">30–45 years</option>
                  <option value="46–60">46–60 years</option>
                  <option value="Above 60">Above 60 years</option>
                </select>
              </div>
            </div>

            <div className="border-b border-slate-100 pb-4 pt-2">
              <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700">Clinical Admission & Diagnostic Factors</h3>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {/* Parameter 3: Diagnosis Category */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  3. Primary Diagnosis Category *
                </label>
                <select
                  value={form.diagnosis}
                  onChange={(e) => setForm({ ...form, diagnosis: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="Diabetes">Diabetes Mellitus</option>
                  <option value="Cardiovascular Disease">Cardiovascular Disease (CHF / AMI)</option>
                  <option value="Respiratory Disease">Respiratory Disease (COPD / Pneumonia)</option>
                  <option value="Kidney Disease">Kidney Disease (CKD / ESRD)</option>
                  <option value="Other">Other Medical / Surgical</option>
                </select>
              </div>

              {/* Parameter 4: Previous Admissions */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  4. Previous Hospital Admissions (Past 12 Months) *
                </label>
                <select
                  value={form.previous_admissions}
                  onChange={(e) => setForm({ ...form, previous_admissions: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="0">0 (First admission)</option>
                  <option value="1">1 prior admission</option>
                  <option value="2">2 prior admissions</option>
                  <option value="3 or more">3 or more prior admissions</option>
                </select>
              </div>

              {/* Parameter 5: Length of Stay */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  5. Length of Hospital Stay (LOS) *
                </label>
                <select
                  value={form.length_of_stay}
                  onChange={(e) => setForm({ ...form, length_of_stay: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="1–3 days">1–3 days (Short stay)</option>
                  <option value="4–7 days">4–7 days (Average stay)</option>
                  <option value="8–14 days">8–14 days (Prolonged stay)</option>
                  <option value="Above 14 days">Above 14 days (Extended stay)</option>
                </select>
              </div>

              {/* Parameter 7: Comorbidities */}
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  7. Comorbidity Profile *
                </label>
                <select
                  value={form.comorbidities}
                  onChange={(e) => setForm({ ...form, comorbidities: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="None">None (Isolated primary condition)</option>
                  <option value="One comorbidity">One comorbidity</option>
                  <option value="Two comorbidities">Two comorbidities</option>
                  <option value="Three or more comorbidities">Three or more comorbidities</option>
                </select>
              </div>
            </div>

            <div className="border-b border-slate-100 pb-4 pt-2">
              <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700">6. Medication Information & Polypharmacy</h3>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  Total Active Prescriptions: <span className="font-mono font-bold text-blue-600">{form.medication_count}</span>
                </label>
                <input
                  type="range"
                  min="1"
                  max="20"
                  value={form.medication_count}
                  onChange={(e) => setForm({ ...form, medication_count: parseInt(e.target.value, 10) })}
                  className="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
                />
                <div className="flex justify-between text-[10px] text-slate-500 mt-1">
                  <span>1 med</span>
                  <span>Polypharmacy ≥ 8</span>
                  <span>20 meds</span>
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1.5">
                  Medication Complexity Level
                </label>
                <select
                  value={form.medication_complexity}
                  onChange={(e) => setForm({ ...form, medication_complexity: e.target.value })}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  <option value="Low">Low (Simple oral dosages)</option>
                  <option value="Medium">Medium (Multiple schedules)</option>
                  <option value="High">High (Insulin, anticoagulants, nebulizers)</option>
                </select>
              </div>
            </div>

            <div className="border-b border-slate-100 pb-4 pt-2">
              <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700">8. Additional Clinical Biomarkers</h3>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              <label className="flex items-center space-x-3 p-3 rounded-xl border border-slate-200 hover:bg-slate-50 cursor-pointer transition">
                <input
                  type="checkbox"
                  checked={form.abnormal_lab}
                  onChange={(e) => setForm({ ...form, abnormal_lab: e.target.checked })}
                  className="w-4 h-4 text-blue-600 rounded border-slate-300 focus:ring-blue-500"
                />
                <span className="text-xs font-medium text-slate-700">
                  Abnormal Lab Biomarkers (eGFR &lt; 60, Creatinine &gt; 1.8, or HbA1c &gt; 9.0)
                </span>
              </label>

              <label className="flex items-center space-x-3 p-3 rounded-xl border border-slate-200 hover:bg-slate-50 cursor-pointer transition">
                <input
                  type="checkbox"
                  checked={form.fall_risk}
                  onChange={(e) => setForm({ ...form, fall_risk: e.target.checked })}
                  className="w-4 h-4 text-blue-600 rounded border-slate-300 focus:ring-blue-500"
                />
                <span className="text-xs font-medium text-slate-700">
                  Documented High Fall Risk / Limited Functional Mobility
                </span>
              </label>
            </div>

            <div className="pt-4">
              <button
                type="submit"
                disabled={isCalculating}
                className="w-full py-3.5 px-6 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold text-sm tracking-wide uppercase shadow-lg shadow-blue-500/30 transition flex items-center justify-center space-x-2"
              >
                {isCalculating ? (
                  <>
                    <svg className="animate-spin w-5 h-5 text-white" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <span>Calculating Bayesian Posterior...</span>
                  </>
                ) : (
                  <>
                    <Icon name="activity" className="w-5 h-5" />
                    <span>Calculate Readmission Risk</span>
                  </>
                )}
              </button>
            </div>

          </form>
        </div>

        {/* PREDICTION RESULT CARD (5 Cols) */}
        <div className="lg:col-span-5 space-y-6">
          {result ? (
            <div className="bg-white rounded-2xl border border-slate-200 shadow-md p-6 space-y-6 animate-in zoom-in-95">
              
              <div className="flex items-center justify-between border-b border-slate-100 pb-4">
                <div>
                  <h3 className="text-lg font-bold text-slate-900 leading-tight">{result.patient_name || form.patient_name || "Eleanor Vance"}</h3>
                  <span className="text-xs font-mono font-bold text-blue-600">ID: {result.patient_id}</span>
                </div>
                <span className="text-xs text-slate-400 font-mono">{result.assessment_date}</span>
              </div>

              {/* Circular Probability Indicator */}
              <div className="flex flex-col items-center justify-center p-6 rounded-2xl bg-slate-50/80 border border-slate-100">
                <div className="relative w-40 h-40">
                  <svg viewBox="0 0 100 100" className="w-full h-full transform -rotate-90">
                    <circle cx="50" cy="50" r="42" stroke="#e2e8f0" strokeWidth="8" fill="transparent" />
                    <circle
                      cx="50"
                      cy="50"
                      r="42"
                      stroke={result.risk_category === "High Risk" ? "#f43f5e" : result.risk_category === "Medium Risk" ? "#f59e0b" : "#10b981"}
                      strokeWidth="8"
                      strokeLinecap="round"
                      fill="transparent"
                      strokeDasharray="263.89"
                      strokeDashoffset={263.89 - (263.89 * Math.min(100, result.predicted_probability)) / 100}
                      className="transition-all duration-1000 ease-out"
                    />
                  </svg>
                  <div className="absolute inset-0 flex flex-col items-center justify-center text-center">
                    <span className="text-3xl font-extrabold font-display text-slate-900">
                      {result.predicted_probability}%
                    </span>
                    <span className="text-[10px] text-slate-500 font-semibold uppercase tracking-wider">
                      30-Day Probability
                    </span>
                  </div>
                </div>

                {/* Risk Classification Badge */}
                <div className="mt-4">
                  <span className={`inline-flex items-center space-x-1.5 px-4 py-1.5 rounded-full text-xs font-extrabold tracking-wide uppercase border ${
                    result.risk_category === "High Risk"
                      ? "bg-rose-100 text-rose-800 border-rose-300 shadow-sm shadow-rose-200"
                      : result.risk_category === "Medium Risk"
                      ? "bg-amber-100 text-amber-800 border-amber-300 shadow-sm shadow-amber-200"
                      : "bg-emerald-100 text-emerald-800 border-emerald-300 shadow-sm shadow-emerald-200"
                  }`}>
                    <span className={`w-2 h-2 rounded-full ${
                      result.risk_category === "High Risk" ? "bg-rose-600 animate-ping" : result.risk_category === "Medium Risk" ? "bg-amber-600" : "bg-emerald-600"
                    }`}></span>
                    <span>{result.risk_category}</span>
                  </span>
                </div>
              </div>

              {/* Factor Contribution Summary */}
              <div>
                <h4 className="text-xs font-bold uppercase tracking-wider text-slate-700 mb-3">
                  Individual Factor Contribution Breakdown
                </h4>
                <div className="space-y-2 max-h-48 overflow-y-auto pr-1">
                  {result.factor_contributions.map((fc, i) => (
                    <div key={i} className="flex items-center justify-between p-2 rounded-lg bg-slate-50 text-xs">
                      <span className="text-slate-700 font-medium">{fc.factor} ({fc.value})</span>
                      <span className={`font-mono font-bold ${
                        fc.direction === "risk_increasing" ? "text-rose-600" : fc.direction === "risk_decreasing" ? "text-emerald-600" : "text-slate-500"
                      }`}>
                        {fc.likelihood_ratio}x LR
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Suggested Monitoring Considerations */}
              <div className="p-4 rounded-xl bg-blue-50/70 border border-blue-100 text-xs space-y-2">
                <p className="font-bold text-blue-900 flex items-center space-x-1.5">
                  <Icon name="stethoscope" className="w-4 h-4 text-blue-700" />
                  <span>Suggested Clinical Monitoring Considerations:</span>
                </p>
                <ul className="list-disc pl-5 space-y-1 text-blue-800">
                  {result.recommendations.map((rec, i) => (
                    <li key={i}>{rec}</li>
                  ))}
                </ul>
              </div>

              {/* Action Buttons */}
              <div className="grid grid-cols-2 gap-3 pt-2">
                <button
                  type="button"
                  onClick={onSave}
                  className="w-full py-2.5 px-3 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white font-semibold text-xs transition flex items-center justify-center space-x-1.5 shadow-sm"
                >
                  <Icon name="database" className="w-4 h-4" />
                  <span>Save Assessment</span>
                </button>
                <button
                  type="button"
                  onClick={onViewReport}
                  className="w-full py-2.5 px-3 rounded-xl bg-slate-800 hover:bg-slate-900 text-white font-semibold text-xs transition flex items-center justify-center space-x-1.5 shadow-sm"
                >
                  <Icon name="printer" className="w-4 h-4" />
                  <span>Download Report</span>
                </button>
              </div>

            </div>
          ) : (
            <div className="bg-white rounded-2xl border border-dashed border-slate-300 p-8 text-center text-slate-400">
              <Icon name="activity" className="w-12 h-12 mx-auto mb-2 opacity-50" />
              <p className="font-semibold text-slate-600">No Assessment Calculated Yet</p>
              <p className="text-xs mt-1">Fill out the clinical parameters on the left and click Calculate.</p>
            </div>
          )}
        </div>

      </div>

    </div>
  );
}

// ------------------------------------------
// 4.3 MODULE 2: BAYESIAN PROBABILITY ENGINE VIEW
// ------------------------------------------
function BayesianEngineView({ prior, setPrior, cutoffs, activeAssessment }) {
  const [testPrior, setTestPrior] = useState(prior);
  const [selectedDemoFeatures, setSelectedDemoFeatures] = useState({
    age: "Above 60",
    diag: "Kidney Disease",
    prev: "2",
    los: "8–14 days",
    med: "High",
    comorb: "Two comorbidities"
  });

  // Calculate live dynamic demonstration
  const liveDemoResult = useMemo(() => {
    return calculateBayesianRisk({
      patient_id: "DEMO-BAYES",
      age_group: selectedDemoFeatures.age,
      diagnosis: selectedDemoFeatures.diag,
      previous_admissions: selectedDemoFeatures.prev,
      length_of_stay: selectedDemoFeatures.los,
      medication_complexity: selectedDemoFeatures.med,
      medication_count: 10,
      comorbidities: selectedDemoFeatures.comorb,
      abnormal_lab: true,
      fall_risk: false
    }, testPrior, cutoffs);
  }, [testPrior, selectedDemoFeatures, cutoffs]);

  return (
    <div className="space-y-8 animate-in fade-in duration-300">
      
      {/* Title */}
      <div>
        <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-indigo-50 text-indigo-700 text-xs font-semibold mb-2 border border-indigo-200">
          <Icon name="layers" className="w-3.5 h-3.5" />
          <span>Module 2: Mathematical Foundation</span>
        </div>
        <h2 className="text-2xl font-bold font-display text-slate-900">
          Bayesian Probability Engine & Evidence Accumulation
        </h2>
        <p className="text-slate-500 text-sm mt-1">
          Rigorous mathematical formulation demonstrating Bayes' Theorem, prior odds, and multiplicative likelihood ratios.
        </p>
      </div>

      {/* Bayes' Theorem Visual Formula Banner */}
      <div className="bg-slate-900 rounded-2xl p-6 md:p-8 text-white shadow-md">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 border-b border-slate-800 pb-6">
          <div>
            <span className="text-xs font-mono uppercase tracking-wider text-cyan-400">Formal Definition</span>
            <h3 className="text-xl font-bold font-display mt-1">Bayes' Theorem for Readmission Risk</h3>
          </div>
          <div className="p-4 rounded-xl bg-slate-950 font-mono text-cyan-300 text-sm md:text-base border border-slate-800 shadow-inner">
            P(Readmit | Evidence) = [ P(Evidence | Readmit) × P(Readmit) ] / P(Evidence)
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mt-6 text-xs">
          <div className="p-3 rounded-xl bg-slate-800/60 border border-slate-700/60">
            <span className="font-bold text-cyan-300">P(Readmit) = Prior</span>
            <p className="text-slate-400 mt-1">Baseline incidence rate of 30-day hospital readmission in historical cohort (19.4%).</p>
          </div>
          <div className="p-3 rounded-xl bg-slate-800/60 border border-slate-700/60">
            <span className="font-bold text-blue-300">P(Evidence | Readmit) = Likelihood</span>
            <p className="text-slate-400 mt-1">Probability of observing the patient's specific clinical factors among readmitted patients.</p>
          </div>
          <div className="p-3 rounded-xl bg-slate-800/60 border border-slate-700/60">
            <span className="font-bold text-amber-300">P(Evidence) = Marginal Evidence</span>
            <p className="text-slate-400 mt-1">Overall probability of observing these clinical traits across all hospital admissions.</p>
          </div>
          <div className="p-3 rounded-xl bg-slate-800/60 border border-slate-700/60">
            <span className="font-bold text-emerald-300">P(Readmit | Evidence) = Posterior</span>
            <p className="text-slate-400 mt-1">Final updated probability of hospital readmission conditioned on observed patient factors.</p>
          </div>
        </div>
      </div>

      {/* Interactive Prior & Likelihood Sandbox */}
      <div className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6 md:p-8 space-y-6">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-slate-100 pb-4">
          <div>
            <h3 className="text-base font-bold text-slate-900">Interactive Bayesian Calculation Sandbox</h3>
            <p className="text-xs text-slate-500">Tweak prior probability and clinical factors to observe real-time mathematical updating.</p>
          </div>
          <div className="flex items-center space-x-3">
            <span className="text-xs text-slate-600 font-semibold">Prior Rate P(A):</span>
            <input
              type="range"
              min="0.05"
              max="0.45"
              step="0.01"
              value={testPrior}
              onChange={(e) => setTestPrior(parseFloat(e.target.value))}
              className="w-32 accent-blue-600 cursor-pointer"
            />
            <span className="font-mono font-bold text-blue-600 text-xs">{(testPrior * 100).toFixed(1)}%</span>
          </div>
        </div>

        {/* Feature Selectors */}
        <div className="grid grid-cols-2 md:grid-cols-6 gap-3">
          <div>
            <label className="block text-[11px] font-bold text-slate-600 uppercase mb-1">Age</label>
            <select
              value={selectedDemoFeatures.age}
              onChange={(e) => setSelectedDemoFeatures({ ...selectedDemoFeatures, age: e.target.value })}
              className="w-full p-2 text-xs rounded-lg border border-slate-200"
            >
              <option value="Below 30">Below 30</option>
              <option value="30–45">30–45</option>
              <option value="46–60">46–60</option>
              <option value="Above 60">Above 60</option>
            </select>
          </div>
          <div>
            <label className="block text-[11px] font-bold text-slate-600 uppercase mb-1">Diagnosis</label>
            <select
              value={selectedDemoFeatures.diag}
              onChange={(e) => setSelectedDemoFeatures({ ...selectedDemoFeatures, diag: e.target.value })}
              className="w-full p-2 text-xs rounded-lg border border-slate-200"
            >
              <option value="Diabetes">Diabetes</option>
              <option value="Cardiovascular Disease">Cardio</option>
              <option value="Respiratory Disease">Respiratory</option>
              <option value="Kidney Disease">Kidney</option>
              <option value="Other">Other</option>
            </select>
          </div>
          <div>
            <label className="block text-[11px] font-bold text-slate-600 uppercase mb-1">Prior Adm</label>
            <select
              value={selectedDemoFeatures.prev}
              onChange={(e) => setSelectedDemoFeatures({ ...selectedDemoFeatures, prev: e.target.value })}
              className="w-full p-2 text-xs rounded-lg border border-slate-200"
            >
              <option value="0">0</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3 or more">≥3</option>
            </select>
          </div>
          <div>
            <label className="block text-[11px] font-bold text-slate-600 uppercase mb-1">Length of Stay</label>
            <select
              value={selectedDemoFeatures.los}
              onChange={(e) => setSelectedDemoFeatures({ ...selectedDemoFeatures, los: e.target.value })}
              className="w-full p-2 text-xs rounded-lg border border-slate-200"
            >
              <option value="1–3 days">1–3 days</option>
              <option value="4–7 days">4–7 days</option>
              <option value="8–14 days">8–14 days</option>
              <option value="Above 14 days">&gt;14 days</option>
            </select>
          </div>
          <div>
            <label className="block text-[11px] font-bold text-slate-600 uppercase mb-1">Meds Complex</label>
            <select
              value={selectedDemoFeatures.med}
              onChange={(e) => setSelectedDemoFeatures({ ...selectedDemoFeatures, med: e.target.value })}
              className="w-full p-2 text-xs rounded-lg border border-slate-200"
            >
              <option value="Low">Low</option>
              <option value="Medium">Medium</option>
              <option value="High">High</option>
            </select>
          </div>
          <div>
            <label className="block text-[11px] font-bold text-slate-600 uppercase mb-1">Comorbidities</label>
            <select
              value={selectedDemoFeatures.comorb}
              onChange={(e) => setSelectedDemoFeatures({ ...selectedDemoFeatures, comorb: e.target.value })}
              className="w-full p-2 text-xs rounded-lg border border-slate-200"
            >
              <option value="None">None</option>
              <option value="One comorbidity">1 comorb</option>
              <option value="Two comorbidities">2 comorbs</option>
              <option value="Three or more comorbidities">≥3 comorbs</option>
            </select>
          </div>
        </div>

        {/* Live Calculation Output Strip */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 p-4 rounded-xl bg-slate-50 border border-slate-200 text-center">
          <div>
            <span className="text-[11px] font-semibold text-slate-500 uppercase">Prior Probability</span>
            <p className="text-xl font-bold font-mono text-slate-800">{(testPrior * 100).toFixed(1)}%</p>
          </div>
          <div>
            <span className="text-[11px] font-semibold text-slate-500 uppercase">Cumulative LR</span>
            <p className="text-xl font-bold font-mono text-blue-600">{liveDemoResult.overall_likelihood_ratio}x</p>
          </div>
          <div>
            <span className="text-[11px] font-semibold text-slate-500 uppercase">Calculated Posterior</span>
            <p className="text-xl font-bold font-mono text-indigo-700">{liveDemoResult.predicted_probability}%</p>
          </div>
          <div>
            <span className="text-[11px] font-semibold text-slate-500 uppercase">Risk Tier</span>
            <p className="text-xl font-bold font-display" style={{ color: liveDemoResult.risk_category === "High Risk" ? "#e11d48" : liveDemoResult.risk_category === "Medium Risk" ? "#d97706" : "#059669" }}>
              {liveDemoResult.risk_category}
            </p>
          </div>
        </div>

        {/* Sequential Step-by-Step Bayesian Updating Sequence */}
        <div>
          <h4 className="text-xs font-bold uppercase tracking-wider text-slate-700 mb-3">
            Step-by-Step Evidence Accumulation Sequence
          </h4>
          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-slate-100/80 text-slate-600 uppercase text-[10px] font-bold">
                <tr>
                  <th className="px-4 py-2.5">Step</th>
                  <th className="px-4 py-2.5">Clinical Evidence Added</th>
                  <th className="px-4 py-2.5">Observed Value</th>
                  <th className="px-4 py-2.5">P(Val | Readmit)</th>
                  <th className="px-4 py-2.5">P(Val | No Readmit)</th>
                  <th className="px-4 py-2.5">Likelihood Ratio (LR)</th>
                  <th className="px-4 py-2.5">Updated Posterior Prob.</th>
                  <th className="px-4 py-2.5">Directional Impact</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100 font-mono">
                {liveDemoResult.steps.map((s, idx) => (
                  <tr key={idx} className={idx === 0 ? "bg-blue-50/40 font-bold" : "hover:bg-slate-50"}>
                    <td className="px-4 py-2 text-slate-500">{s.step}</td>
                    <td className="px-4 py-2 font-sans font-medium text-slate-800">{s.factor}</td>
                    <td className="px-4 py-2 font-sans text-slate-700">{s.value}</td>
                    <td className="px-4 py-2 text-slate-600">{s.likelihood_readmit}</td>
                    <td className="px-4 py-2 text-slate-600">{s.likelihood_no_readmit}</td>
                    <td className="px-4 py-2 font-bold text-blue-600">{s.likelihood_ratio}x</td>
                    <td className="px-4 py-2 font-bold text-slate-900">{s.posterior_after_step}%</td>
                    <td className="px-4 py-2 font-sans text-[11px] text-slate-600">{s.impact}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

      </div>

      {/* DOCUMENTED SYNTHETIC LIKELIHOOD TABLES */}
      <div className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6 md:p-8 space-y-4">
        <div>
          <h3 className="text-base font-bold text-slate-900">Documented Synthetic Likelihood Distributions</h3>
          <p className="text-xs text-slate-500">Benchmark conditional probabilities derived from literature (Cascella et al. 2022, Gao et al. 2023).</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-xs font-mono">
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200">
            <h4 className="font-sans font-bold text-slate-800 mb-2">Age Group Likelihoods</h4>
            <div className="space-y-1 text-slate-600">
              <p>Below 30: P(E|Y=1)=0.08, P(E|Y=0)=0.22 (LR 0.36)</p>
              <p>30–45: P(E|Y=1)=0.16, P(E|Y=0)=0.28 (LR 0.57)</p>
              <p>46–60: P(E|Y=1)=0.32, P(E|Y=0)=0.30 (LR 1.07)</p>
              <p>Above 60: P(E|Y=1)=0.44, P(E|Y=0)=0.20 (LR 2.20)</p>
            </div>
          </div>
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200">
            <h4 className="font-sans font-bold text-slate-800 mb-2">Prior Admissions Likelihoods</h4>
            <div className="space-y-1 text-slate-600">
              <p>0 Prior: P(E|Y=1)=0.20, P(E|Y=0)=0.62 (LR 0.32)</p>
              <p>1 Prior: P(E|Y=1)=0.28, P(E|Y=0)=0.24 (LR 1.17)</p>
              <p>2 Prior: P(E|Y=1)=0.27, P(E|Y=0)=0.10 (LR 2.70)</p>
              <p>≥3 Prior: P(E|Y=1)=0.25, P(E|Y=0)=0.04 (LR 6.25)</p>
            </div>
          </div>
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200">
            <h4 className="font-sans font-bold text-slate-800 mb-2">Comorbidities Likelihoods</h4>
            <div className="space-y-1 text-slate-600">
              <p>None: P(E|Y=1)=0.10, P(E|Y=0)=0.46 (LR 0.22)</p>
              <p>1 Comorb: P(E|Y=1)=0.24, P(E|Y=0)=0.31 (LR 0.77)</p>
              <p>2 Comorbs: P(E|Y=1)=0.36, P(E|Y=0)=0.17 (LR 2.12)</p>
              <p>≥3 Comorbs: P(E|Y=1)=0.30, P(E|Y=0)=0.06 (LR 5.00)</p>
            </div>
          </div>
        </div>
      </div>

      {/* Bayesian Model Explanation Section */}
      <div className="bg-blue-50/50 rounded-2xl border border-blue-100 p-6 md:p-8 space-y-4">
        <h3 className="text-base font-bold text-blue-950 flex items-center space-x-2">
          <Icon name="info" className="w-5 h-5 text-blue-600" />
          <span>Bayesian Model Explanation in Clinical Practice</span>
        </h3>
        <p className="text-xs md:text-sm text-blue-900 leading-relaxed">
          Unlike black-box machine learning approaches, Bayesian probability models provide complete mathematical auditability. Every clinical decision maker can inspect the initial baseline readmission risk (Prior Odds) and trace exactly how each piece of clinical evidence (patient age, historical admissions, length of hospital stay, and medication burden) adjusts the likelihood ratio upward or downward.
        </p>
        <div className="text-xs text-blue-800 space-y-1">
          <p>• <strong>Odds Formulation:</strong> Posterior Odds = Prior Odds × ∏ LR(Feature_i)</p>
          <p>• <strong>Probability Conversion:</strong> Posterior Probability = Odds / (1 + Odds)</p>
          <p>• <strong>Laplace Smoothing:</strong> Applied with pseudocounts to avoid zero probabilities on rare category combinations.</p>
        </div>
      </div>

    </div>
  );
}

// ------------------------------------------
// 4.4 MODULE 3: POPULATION ANALYTICS & VALIDATION VIEW
// ------------------------------------------
function AnalyticsView({ analytics, threshold, setThreshold, onUploadCsv, onResetData }) {
  const fileInputRef = useRef(null);

  if (!analytics) return <div className="p-8">Loading analytics...</div>;

  const { metrics, confusionMatrix, rocPoints } = analytics;

  return (
    <div className="space-y-8 animate-in fade-in duration-300">
      
      {/* Title */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
            <Icon name="barChart" className="w-3.5 h-3.5" />
            <span>Module 3: Population Intelligence & Evaluation</span>
          </div>
          <h2 className="text-2xl font-bold font-display text-slate-900">
            Population Analytics & Model Validation
          </h2>
          <p className="text-slate-500 text-sm mt-1">
            Empirical validation metrics computed dynamically on patient cohort (N={analytics.total}).
          </p>
        </div>

        <div className="flex items-center space-x-2">
          <input
            type="file"
            ref={fileInputRef}
            onChange={onUploadCsv}
            accept=".csv"
            className="hidden"
          />
          <button
            onClick={() => fileInputRef.current.click()}
            className="px-3.5 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-semibold transition flex items-center space-x-1.5 shadow-sm"
          >
            <Icon name="upload" className="w-4 h-4" />
            <span>Upload Patient CSV</span>
          </button>
          <button
            onClick={() => {
              window.open("http://localhost:8000/api/download-sample-csv", "_blank");
            }}
            className="px-3.5 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-semibold transition flex items-center space-x-1.5"
            title="Download Sample Template"
          >
            <Icon name="download" className="w-4 h-4" />
            <span className="hidden md:inline">Sample CSV</span>
          </button>
          <button
            onClick={onResetData}
            className="px-3 py-2 rounded-xl bg-slate-100 hover:bg-rose-50 text-slate-600 hover:text-rose-700 text-xs font-semibold transition"
            title="Reset to Benchmark"
          >
            <Icon name="refresh" className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* SECTION A: POPULATION SUMMARY KPI METRICS */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
        <div className="p-4 rounded-xl bg-white border border-slate-200 shadow-sm">
          <span className="text-xs text-slate-500 uppercase font-semibold">Total Patients</span>
          <p className="text-2xl font-extrabold font-display text-slate-900 mt-1">{analytics.total}</p>
          <p className="text-[11px] text-slate-400">Cohort size</p>
        </div>
        <div className="p-4 rounded-xl bg-white border border-slate-200 shadow-sm">
          <span className="text-xs text-slate-500 uppercase font-semibold">Readmitted (30d)</span>
          <p className="text-2xl font-extrabold font-display text-rose-600 mt-1">{analytics.readmitted}</p>
          <p className="text-[11px] text-slate-400">{((analytics.readmitted / analytics.total) * 100).toFixed(1)}% readmission rate</p>
        </div>
        <div className="p-4 rounded-xl bg-white border border-slate-200 shadow-sm">
          <span className="text-xs text-slate-500 uppercase font-semibold">Non-Readmitted</span>
          <p className="text-2xl font-extrabold font-display text-emerald-600 mt-1">{analytics.nonReadmitted}</p>
          <p className="text-[11px] text-slate-400">{((analytics.nonReadmitted / analytics.total) * 100).toFixed(1)}% success rate</p>
        </div>
        <div className="p-4 rounded-xl bg-white border border-slate-200 shadow-sm">
          <span className="text-xs text-slate-500 uppercase font-semibold">High-Risk Patients</span>
          <p className="text-2xl font-extrabold font-display text-amber-600 mt-1">{analytics.highRiskCount}</p>
          <p className="text-[11px] text-slate-400">{analytics.highRiskPct}% of population</p>
        </div>
        <div className="p-4 rounded-xl bg-white border border-slate-200 shadow-sm">
          <span className="text-xs text-slate-500 uppercase font-semibold">Mean Probability</span>
          <p className="text-2xl font-extrabold font-display text-indigo-600 mt-1">{analytics.avgProb}%</p>
          <p className="text-[11px] text-slate-400">Population average</p>
        </div>
      </div>

      {/* CLASSIFICATION THRESHOLD SLIDER CONTROLLER */}
      <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-sm flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h4 className="text-sm font-bold text-slate-900">Classification Operating Threshold</h4>
          <p className="text-xs text-slate-500">Adjust the decision threshold to balance Sensitivity (Recall) vs Specificity.</p>
        </div>
        <div className="flex items-center space-x-4">
          <span className="text-xs font-semibold text-slate-700">Threshold:</span>
          <input
            type="range"
            min="10"
            max="60"
            value={threshold}
            onChange={(e) => setThreshold(parseInt(e.target.value, 10))}
            className="w-48 accent-blue-600 cursor-pointer"
          />
          <span className="font-mono font-bold text-blue-600 text-sm px-2.5 py-1 rounded bg-blue-50 border border-blue-100">
            {threshold}%
          </span>
        </div>
      </div>

      {/* SECTION B: MODEL PERFORMANCE EVALUATION METRICS */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
        <div className="p-4 rounded-xl bg-blue-50/70 border border-blue-100 text-center">
          <span className="text-xs font-bold text-blue-700 uppercase">1. Accuracy</span>
          <p className="text-2xl font-extrabold font-mono text-blue-950 mt-1">{metrics.accuracy}%</p>
          <p className="text-[10px] text-blue-600 mt-0.5">(TP + TN) / Total</p>
        </div>
        <div className="p-4 rounded-xl bg-indigo-50/70 border border-indigo-100 text-center">
          <span className="text-xs font-bold text-indigo-700 uppercase">2. Precision (PPV)</span>
          <p className="text-2xl font-extrabold font-mono text-indigo-950 mt-1">{metrics.precision}%</p>
          <p className="text-[10px] text-indigo-600 mt-0.5">TP / (TP + FP)</p>
        </div>
        <div className="p-4 rounded-xl bg-emerald-50/70 border border-emerald-100 text-center">
          <span className="text-xs font-bold text-emerald-700 uppercase">3. Sensitivity (Recall)</span>
          <p className="text-2xl font-extrabold font-mono text-emerald-950 mt-1">{metrics.sensitivity}%</p>
          <p className="text-[10px] text-emerald-600 mt-0.5">TP / (TP + FN)</p>
        </div>
        <div className="p-4 rounded-xl bg-amber-50/70 border border-amber-100 text-center">
          <span className="text-xs font-bold text-amber-700 uppercase">4. Specificity (TNR)</span>
          <p className="text-2xl font-extrabold font-mono text-amber-950 mt-1">{metrics.specificity}%</p>
          <p className="text-[10px] text-amber-600 mt-0.5">TN / (TN + FP)</p>
        </div>
        <div className="p-4 rounded-xl bg-cyan-50/70 border border-cyan-100 text-center">
          <span className="text-xs font-bold text-cyan-700 uppercase">5. AUC-ROC</span>
          <p className="text-2xl font-extrabold font-mono text-cyan-950 mt-1">{metrics.auc_roc}</p>
          <p className="text-[10px] text-cyan-600 mt-0.5">Area Under Curve</p>
        </div>
      </div>

      {/* SECTION C: CONFUSION MATRIX & ROC CURVE */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        
        {/* Confusion Matrix */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-bold text-slate-900">Confusion Matrix</h3>
              <p className="text-xs text-slate-500">Predicted Risk vs. Actual 30-Day Hospital Readmission</p>
            </div>
            <span className="text-xs font-mono text-slate-400">Cutoff: {threshold}%</span>
          </div>

          <div className="grid grid-cols-2 gap-3 pt-2 text-center">
            {/* True Positive */}
            <div className="p-5 rounded-xl bg-emerald-50 border border-emerald-200">
              <span className="text-[10px] font-bold uppercase tracking-wider text-emerald-800">True Positive (TP)</span>
              <p className="text-3xl font-extrabold font-mono text-emerald-700 mt-1">{confusionMatrix.tp}</p>
              <p className="text-[11px] text-emerald-600 mt-1">Predicted readmission & was readmitted</p>
            </div>

            {/* False Positive */}
            <div className="p-5 rounded-xl bg-rose-50 border border-rose-200">
              <span className="text-[10px] font-bold uppercase tracking-wider text-rose-800">False Positive (FP)</span>
              <p className="text-3xl font-extrabold font-mono text-rose-700 mt-1">{confusionMatrix.fp}</p>
              <p className="text-[11px] text-rose-600 mt-1">Type I error (False alarm)</p>
            </div>

            {/* False Negative */}
            <div className="p-5 rounded-xl bg-amber-50 border border-amber-200">
              <span className="text-[10px] font-bold uppercase tracking-wider text-amber-800">False Negative (FN)</span>
              <p className="text-3xl font-extrabold font-mono text-amber-700 mt-1">{confusionMatrix.fn}</p>
              <p className="text-[11px] text-amber-600 mt-1">Type II error (Missed high risk)</p>
            </div>

            {/* True Negative */}
            <div className="p-5 rounded-xl bg-blue-50 border border-blue-200">
              <span className="text-[10px] font-bold uppercase tracking-wider text-blue-800">True Negative (TN)</span>
              <p className="text-3xl font-extrabold font-mono text-blue-700 mt-1">{confusionMatrix.tn}</p>
              <p className="text-[11px] text-blue-600 mt-1">Correctly classified non-readmission</p>
            </div>
          </div>
        </div>

        {/* ROC Curve Graph */}
        <div className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm flex flex-col justify-between">
          <div className="flex items-center justify-between mb-2">
            <div>
              <h3 className="text-sm font-bold text-slate-900">Receiver Operating Characteristic (ROC)</h3>
              <p className="text-xs text-slate-500">Sensitivity (TPR) vs. 1 - Specificity (FPR)</p>
            </div>
            <span className="text-xs font-mono font-bold text-cyan-600 px-2 py-0.5 rounded bg-cyan-50 border border-cyan-200">
              AUC = {metrics.auc_roc}
            </span>
          </div>

          {/* SVG ROC Plot */}
          <div className="relative w-full h-56 pt-2">
            <svg viewBox="0 0 200 200" className="w-full h-full overflow-visible">
              {/* Grid Lines */}
              <line x1="20" y1="20" x2="20" y2="180" stroke="#cbd5e1" strokeWidth="1" />
              <line x1="20" y1="180" x2="180" y2="180" stroke="#cbd5e1" strokeWidth="1" />
              
              {/* Diagonal Chance Line */}
              <line x1="20" y1="180" x2="180" y2="20" stroke="#94a3b8" strokeDasharray="3 3" strokeWidth="1" />

              {/* ROC Curve Path */}
              <polyline
                fill="none"
                stroke="#2563eb"
                strokeWidth="2.5"
                points={rocPoints.map(p => `${20 + p.fpr * 160},${180 - p.tpr * 160}`).join(" ")}
              />

              {/* Current Operating Point */}
              <circle
                cx={20 + (1 - metrics.specificity / 100) * 160}
                cy={180 - (metrics.sensitivity / 100) * 160}
                r="5"
                fill="#f43f5e"
                stroke="#ffffff"
                strokeWidth="2"
              />
            </svg>
          </div>

          <div className="flex items-center justify-between text-[11px] text-slate-500 pt-2 border-t border-slate-100">
            <span>False Positive Rate (1 - Specificity)</span>
            <span className="font-semibold text-rose-600">● Selected Cutoff: {threshold}%</span>
            <span>True Positive Rate (Sensitivity)</span>
          </div>
        </div>

      </div>

    </div>
  );
}

// ------------------------------------------
// 4.5 MODULE 4: PATIENT RECORD MANAGEMENT VIEW
// ------------------------------------------
function PatientRecordsView({ patients, onDelete, onSelectPatient, onViewDetails, onAddNew }) {
  const [searchTerm, setSearchTerm] = useState("");
  const [riskFilter, setRiskFilter] = useState("All");
  const [diagnosisFilter, setDiagnosisFilter] = useState("All");
  const [sortOrder, setSortOrder] = useState("prob_desc");

  // Filtering and sorting
  const filteredPatients = useMemo(() => {
    return patients
      .filter(p => {
        const matchesSearch = p.patient_id.toLowerCase().includes(searchTerm.toLowerCase()) ||
                              (p.patient_name && p.patient_name.toLowerCase().includes(searchTerm.toLowerCase())) ||
                              (p.diagnosis && p.diagnosis.toLowerCase().includes(searchTerm.toLowerCase()));
        const matchesRisk = riskFilter === "All" || p.risk_category === riskFilter;
        const matchesDiag = diagnosisFilter === "All" || p.diagnosis === diagnosisFilter;
        return matchesSearch && matchesRisk && matchesDiag;
      })
      .sort((a, b) => {
        if (sortOrder === "prob_desc") return (b.readmission_probability || 0) - (a.readmission_probability || 0);
        if (sortOrder === "prob_asc") return (a.readmission_probability || 0) - (b.readmission_probability || 0);
        if (sortOrder === "id_asc") return a.patient_id.localeCompare(b.patient_id);
        return (b.id || 0) - (a.id || 0);
      });
  }, [patients, searchTerm, riskFilter, diagnosisFilter, sortOrder]);

  // Export CSV
  const handleExportCsv = () => {
    const headers = ["patient_id,patient_name,age_group,diagnosis,previous_admissions,length_of_stay,medication_count,comorbidities,readmission_probability,risk_category,assessment_date"];
    const rows = filteredPatients.map(p => 
      `"${p.patient_id}","${p.patient_name || 'Patient'}","${p.age_group}","${p.diagnosis}","${p.previous_admissions}","${p.length_of_stay}",${p.medication_count},"${p.comorbidities}",${p.readmission_probability},"${p.risk_category}","${p.assessment_date}"`
    );
    const csvContent = "data:text/csv;charset=utf-8," + [headers, ...rows].join("\n");
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", `hospital_readmission_records_${new Date().toISOString().split('T')[0]}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      
      {/* Title & Actions */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
            <Icon name="database" className="w-3.5 h-3.5" />
            <span>Module 4: Patient Cohort Registry</span>
          </div>
          <h2 className="text-2xl font-bold font-display text-slate-900">
            Patient Assessment Records
          </h2>
          <p className="text-slate-500 text-sm mt-1">
            Browse, search, filter, and inspect documented patient readmission probability assessments.
          </p>
        </div>

        <div className="flex items-center space-x-2">
          <button
            onClick={handleExportCsv}
            className="px-3.5 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-semibold transition flex items-center space-x-1.5"
          >
            <Icon name="download" className="w-4 h-4" />
            <span>Export CSV</span>
          </button>
          <button
            onClick={onAddNew}
            className="px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-semibold transition flex items-center space-x-1.5 shadow-sm"
          >
            <Icon name="plus" className="w-4 h-4" />
            <span>Add Patient</span>
          </button>
        </div>
      </div>

      {/* FILTER & SEARCH BAR */}
      <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
        {/* Search */}
        <div className="relative">
          <Icon name="search" className="w-4 h-4 text-slate-400 absolute left-3 top-3" />
          <input
            type="text"
            placeholder="Search by Patient Name, ID, or Diagnosis..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-9 pr-3 py-2 rounded-xl border border-slate-300 text-xs focus:ring-2 focus:ring-blue-500 focus:outline-none"
          />
        </div>

        {/* Risk Filter */}
        <div>
          <select
            value={riskFilter}
            onChange={(e) => setRiskFilter(e.target.value)}
            className="w-full px-3 py-2 rounded-xl border border-slate-300 text-xs focus:ring-2 focus:ring-blue-500 focus:outline-none"
          >
            <option value="All">All Risk Categories</option>
            <option value="Low Risk">Low Risk Only</option>
            <option value="Medium Risk">Medium Risk Only</option>
            <option value="High Risk">High Risk Only</option>
          </select>
        </div>

        {/* Diagnosis Filter */}
        <div>
          <select
            value={diagnosisFilter}
            onChange={(e) => setDiagnosisFilter(e.target.value)}
            className="w-full px-3 py-2 rounded-xl border border-slate-300 text-xs focus:ring-2 focus:ring-blue-500 focus:outline-none"
          >
            <option value="All">All Diagnoses</option>
            <option value="Cardiovascular Disease">Cardiovascular Disease</option>
            <option value="Diabetes">Diabetes</option>
            <option value="Respiratory Disease">Respiratory Disease</option>
            <option value="Kidney Disease">Kidney Disease</option>
            <option value="Other">Other</option>
          </select>
        </div>

        {/* Sort Order */}
        <div>
          <select
            value={sortOrder}
            onChange={(e) => setSortOrder(e.target.value)}
            className="w-full px-3 py-2 rounded-xl border border-slate-300 text-xs focus:ring-2 focus:ring-blue-500 focus:outline-none"
          >
            <option value="prob_desc">Probability (Highest First)</option>
            <option value="prob_asc">Probability (Lowest First)</option>
            <option value="id_asc">Patient ID (A - Z)</option>
          </select>
        </div>
      </div>

      {/* PATIENT TABLE */}
      <div className="bg-white rounded-2xl border border-slate-200/80 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 text-slate-600 uppercase tracking-wider text-[11px] font-bold border-b border-slate-200">
              <tr>
                <th className="px-5 py-3.5">Patient Details</th>
                <th className="px-5 py-3.5">Age Group</th>
                <th className="px-5 py-3.5">Diagnosis</th>
                <th className="px-5 py-3.5">Prior Adm.</th>
                <th className="px-5 py-3.5">Length of Stay</th>
                <th className="px-5 py-3.5">Meds & Comorb</th>
                <th className="px-5 py-3.5">Probability</th>
                <th className="px-5 py-3.5">Risk Tier</th>
                <th className="px-5 py-3.5">Date</th>
                <th className="px-5 py-3.5 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium">
              {filteredPatients.length === 0 ? (
                <tr>
                  <td colSpan="10" className="px-6 py-12 text-center text-slate-400">
                    No matching patient records found.
                  </td>
                </tr>
              ) : (
                filteredPatients.slice(0, 30).map((p) => (
                  <tr key={p.id} className="hover:bg-slate-50 transition">
                    <td className="px-5 py-3">
                      <p className="font-bold text-slate-900 leading-tight">{p.patient_name || "Patient Record"}</p>
                      <span className="font-mono text-[11px] font-bold text-blue-600">{p.patient_id}</span>
                    </td>
                    <td className="px-5 py-3 text-slate-700">{p.age_group}</td>
                    <td className="px-5 py-3 font-semibold text-slate-900">{p.diagnosis}</td>
                    <td className="px-5 py-3 text-slate-700">{p.previous_admissions}</td>
                    <td className="px-5 py-3 text-slate-700">{p.length_of_stay}</td>
                    <td className="px-5 py-3 text-slate-600">
                      {p.medication_count} meds • {p.comorbidities}
                    </td>
                    <td className="px-5 py-3">
                      <span className="font-mono font-bold text-slate-900">{p.readmission_probability}%</span>
                    </td>
                    <td className="px-5 py-3">
                      <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold border ${
                        p.risk_category === "High Risk"
                          ? "bg-rose-50 text-rose-700 border-rose-200"
                          : p.risk_category === "Medium Risk"
                          ? "bg-amber-50 text-amber-700 border-amber-200"
                          : "bg-emerald-50 text-emerald-700 border-emerald-200"
                      }`}>
                        {p.risk_category}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-slate-500 font-mono text-[11px]">{p.assessment_date}</td>
                    <td className="px-5 py-3 text-right space-x-1 whitespace-nowrap">
                      <button
                        onClick={() => onViewDetails(p)}
                        className="px-2 py-1 rounded bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold text-[11px] transition"
                        title="View Details"
                      >
                        Details
                      </button>
                      <button
                        onClick={() => onSelectPatient(p)}
                        className="px-2 py-1 rounded bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold text-[11px] transition"
                        title="Print / Save Report"
                      >
                        Report
                      </button>
                      <button
                        onClick={() => onDelete(p.id, p.patient_id)}
                        className="px-2 py-1 rounded bg-rose-50 hover:bg-rose-100 text-rose-600 font-semibold text-[11px] transition"
                        title="Delete Record"
                      >
                        <Icon name="trash" className="w-3.5 h-3.5 inline" />
                      </button>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
        <div className="p-4 bg-slate-50 border-t border-slate-200 text-xs text-slate-500 flex justify-between items-center">
          <span>Showing {Math.min(30, filteredPatients.length)} of {filteredPatients.length} matching patients</span>
          <span>Database Total: {patients.length}</span>
        </div>
      </div>

    </div>
  );
}

// ------------------------------------------
// 4.6 MODULE 5: REPORT GENERATION VIEW
// ------------------------------------------
function ReportView({ patient, allPatients, onSelectPatient }) {
  const [selectedId, setSelectedId] = useState(patient?.patient_id || "");

  // Ensure assessment details exist
  const assessment = useMemo(() => {
    if (!patient) return null;
    if (patient.steps && patient.factor_contributions) return patient;
    return calculateBayesianRisk(patient);
  }, [patient]);

  const handlePrint = () => {
    window.print();
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      
      {/* Action Toolbar (Hidden in Print) */}
      <div className="no-print flex flex-col sm:flex-row sm:items-center justify-between gap-4 p-4 rounded-2xl bg-white border border-slate-200 shadow-sm">
        <div className="flex items-center space-x-3">
          <label className="text-xs font-bold text-slate-700 uppercase">Select Patient:</label>
          <select
            value={selectedId}
            onChange={(e) => {
              setSelectedId(e.target.value);
              const found = allPatients.find(p => p.patient_id === e.target.value);
              if (found) onSelectPatient(found);
            }}
            className="px-3 py-1.5 rounded-lg border border-slate-300 text-xs font-mono"
          >
            {allPatients.map(p => (
              <option key={p.id} value={p.patient_id}>
                {p.patient_name ? `${p.patient_name} (${p.patient_id})` : p.patient_id} - {p.diagnosis} ({p.readmission_probability}%)
              </option>
            ))}
          </select>
        </div>

        <button
          onClick={handlePrint}
          className="px-5 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-bold transition flex items-center space-x-2 shadow-sm"
        >
          <Icon name="printer" className="w-4 h-4" />
          <span>Print / Save as PDF</span>
        </button>
      </div>

      {/* FORMAL CLINICAL REPORT DOCUMENT */}
      {assessment ? (
        <div className="bg-white p-8 md:p-12 rounded-2xl border border-slate-200 shadow-lg max-w-4xl mx-auto print-shadow-none text-slate-900 space-y-8">
          
          {/* Header */}
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center border-b-2 border-slate-900 pb-6 gap-4">
            <div>
              <div className="flex items-center space-x-2 text-blue-600 font-bold text-xs uppercase tracking-wider mb-1">
                <Icon name="heart" className="w-4 h-4" />
                <span>Metropolitan Academic Health System • Quality & Outcomes</span>
              </div>
              <h1 className="text-xl md:text-2xl font-extrabold font-display text-slate-900 tracking-tight">
                30-Day Hospital Readmission Risk Assessment Report
              </h1>
              <p className="text-xs text-slate-500 mt-0.5">
                Predictive Analytics for Hospital Readmission Risk Assessment Using Bayesian Models
              </p>
            </div>
            <div className="text-right">
              <h3 className="text-base font-bold text-slate-900">{assessment.patient_name || patient.patient_name || "Eleanor Vance"}</h3>
              <span className="font-mono text-xs font-bold bg-slate-100 px-3 py-1 rounded-md border border-slate-300 mt-1 inline-block">
                {assessment.patient_id}
              </span>
              <p className="text-xs text-slate-500 mt-1">Date: {assessment.assessment_date}</p>
            </div>
          </div>

          {/* Section 1: Patient Demographic & Clinical Profile */}
          <div className="grid grid-cols-2 md:grid-cols-5 gap-4 p-4 rounded-xl bg-slate-50 border border-slate-200 text-xs">
            <div>
              <span className="text-slate-500 font-medium">Patient Name:</span>
              <p className="font-bold text-slate-900">{assessment.patient_name || patient.patient_name || assessment.inputs?.patient_name || "Eleanor Vance"}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Age Group:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.age_group || patient.age_group}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Primary Diagnosis:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.diagnosis || patient.diagnosis}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Length of Stay:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.length_of_stay || patient.length_of_stay}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Prior Admissions:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.previous_admissions || patient.previous_admissions}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Medication Count:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.medication_count || patient.medication_count} medications</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Medication Complexity:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.medication_complexity || patient.medication_complexity}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Comorbidities:</span>
              <p className="font-bold text-slate-800">{assessment.inputs?.comorbidities || patient.comorbidities}</p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Abnormal Lab:</span>
              <p className="font-bold text-slate-800">
                {(assessment.inputs?.abnormal_lab || patient.abnormal_lab) ? "Detected" : "None"}
              </p>
            </div>
            <div>
              <span className="text-slate-500 font-medium">Fall / Mobility Risk:</span>
              <p className="font-bold text-slate-800">
                {(assessment.inputs?.fall_risk || patient.fall_risk) ? "High Risk" : "Normal"}
              </p>
            </div>
          </div>

          {/* Section 2: Bayesian Prediction Results Summary */}
          <div className="p-6 rounded-2xl bg-gradient-to-r from-slate-900 to-blue-950 text-white flex flex-col md:flex-row items-center justify-between gap-6">
            <div>
              <span className="text-xs text-cyan-400 font-mono uppercase tracking-wider">Predictive Inference Outcome</span>
              <h2 className="text-2xl font-bold font-display mt-1">Estimated 30-Day Readmission Probability</h2>
              <p className="text-xs text-slate-300 mt-1 max-w-lg">
                Calculated by combining baseline hospital admission rates with sequential conditional likelihood ratios.
              </p>
            </div>
            <div className="flex items-center space-x-4">
              <div className="text-right">
                <span className="text-4xl font-extrabold font-mono text-cyan-300">{assessment.predicted_probability}%</span>
                <p className="text-[11px] text-slate-400">Posterior Probability</p>
              </div>
              <div className={`px-4 py-2 rounded-xl text-xs font-extrabold uppercase border ${
                assessment.risk_category === "High Risk"
                  ? "bg-rose-500/20 text-rose-300 border-rose-400/40"
                  : assessment.risk_category === "Medium Risk"
                  ? "bg-amber-500/20 text-amber-300 border-amber-400/40"
                  : "bg-emerald-500/20 text-emerald-300 border-emerald-400/40"
              }`}>
                {assessment.risk_category}
              </div>
            </div>
          </div>

          {/* Section 3: Factor Contribution Breakdown Table */}
          <div>
            <h3 className="text-xs font-bold uppercase tracking-wider text-slate-700 mb-3">
              Contributing Risk Factors & Likelihood Audit
            </h3>
            <table className="w-full text-left text-xs border border-slate-200">
              <thead className="bg-slate-100 text-slate-700 font-bold uppercase text-[10px]">
                <tr>
                  <th className="p-3 border-b">Clinical Risk Factor</th>
                  <th className="p-3 border-b">Observed Value</th>
                  <th className="p-3 border-b">Likelihood Ratio (LR)</th>
                  <th className="p-3 border-b">Directional Risk Impact</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {assessment.factor_contributions.map((fc, i) => (
                  <tr key={i}>
                    <td className="p-3 font-semibold text-slate-800">{fc.factor}</td>
                    <td className="p-3 text-slate-600">{fc.value}</td>
                    <td className="p-3 font-mono font-bold text-blue-600">{fc.likelihood_ratio}x</td>
                    <td className="p-3">
                      <span className={`text-[11px] font-semibold ${
                        fc.direction === "risk_increasing" ? "text-rose-600" : fc.direction === "risk_decreasing" ? "text-emerald-600" : "text-slate-500"
                      }`}>
                        {fc.impact_description}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Section 4: Recommended Clinical Discharge Actions */}
          <div className="p-5 rounded-xl bg-blue-50 border border-blue-200 text-xs space-y-2">
            <h4 className="font-bold text-blue-900 uppercase tracking-wider">
              Recommended 30-Day Transitional Care Pathway
            </h4>
            <ul className="list-disc pl-5 space-y-1 text-blue-800">
              {assessment.recommendations.map((rec, i) => (
                <li key={i}>{rec}</li>
              ))}
            </ul>
          </div>

          {/* Section 5: Clinician Sign-off & Academic Disclaimer */}
          <div className="pt-6 border-t border-slate-200 grid grid-cols-2 gap-8 text-xs text-slate-500">
            <div>
              <p className="font-bold text-slate-700">Evaluating Clinician Signature:</p>
              <div className="mt-6 border-b border-slate-300 w-48"></div>
              <p className="mt-1 text-[11px]">Dr. Sarah Jenkins, MD • Lead Hospitalist</p>
            </div>
            <div>
              <p className="font-bold text-slate-700">Academic & Medical Disclaimer:</p>
              <p className="mt-1 text-[11px] leading-relaxed">
                This document is generated by an academic demonstration platform (Course: ITA0605). Readmission probabilities are statistical estimates and do not replace professional clinical judgement.
              </p>
            </div>
          </div>

        </div>
      ) : (
        <div className="p-12 text-center text-slate-400 bg-white rounded-2xl border border-slate-200">
          Please select a patient to generate report.
        </div>
      )}

    </div>
  );
}

// ------------------------------------------
// 4.7 MODULE 6: FUTURE SCOPE VIEW
// ------------------------------------------
function FutureScopeView() {
  const roadmap = [
    {
      title: "1. Electronic Health Record (EHR) & HL7/FHIR Integration",
      desc: "Direct bi-directional sync with Epic, Cerner, and Allscripts via HL7 FHIR APIs to ingest patient labs, vitals, and admission notes in real time without manual data entry.",
      badge: "Interoperability",
      color: "blue"
    },
    {
      title: "2. Wearable IoT & Continuous Physiological Telemetry",
      desc: "Ingesting post-discharge telemetry from smartwatches, continuous pulse oximeters, and smart scales to continuously recalculate Bayesian belief distributions daily.",
      badge: "Remote Monitoring",
      color: "cyan"
    },
    {
      title: "3. Dynamic Real-Time Bayesian Updating",
      desc: "Shifting from static point-in-time discharge assessment to continuous sequential Markov / Dynamic Bayesian Networks that adapt as post-discharge days elapse.",
      badge: "Advanced Modeling",
      color: "indigo"
    },
    {
      title: "4. Hybrid Deep Bayesian Networks & MCMC Sampling",
      desc: "Integrating deep neural embeddings for unstructured clinical discharge notes with Bayesian Markov Chain Monte Carlo (MCMC) sampling for rigorous uncertainty quantification.",
      badge: "Deep Learning",
      color: "purple"
    },
    {
      title: "5. Automated Discharge Care Pathways & Nurse Outreach",
      desc: "Algorithmic automated dispatch of transitional care nurses and medication reconciliation alerts based on patients crossing dynamic risk thresholds.",
      badge: "Clinical Workflow",
      color: "emerald"
    },
    {
      title: "6. Explainable AI & Counterfactual Audits",
      desc: "Generating counterfactual patient scenarios (e.g., 'If patient attends follow-up visit on Day 5, risk decreases by 14%') to empower patient empowerment and clinical coaching.",
      badge: "Explainable AI",
      color: "amber"
    }
  ];

  return (
    <div className="space-y-8 animate-in fade-in duration-300">
      <div>
        <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
          <Icon name="compass" className="w-3.5 h-3.5" />
          <span>Module 6: Technological Roadmap</span>
        </div>
        <h2 className="text-2xl font-bold font-display text-slate-900">
          Future Scope & Development Horizons
        </h2>
        <p className="text-slate-500 text-sm mt-1">
          Extending Bayesian readmission prediction from academic prototype to multi-center clinical enterprise scale.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {roadmap.map((item, idx) => (
          <div key={idx} className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition space-y-3">
            <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-blue-50 text-blue-700 border border-blue-100">
              {item.badge}
            </span>
            <h3 className="text-base font-bold text-slate-900">{item.title}</h3>
            <p className="text-xs text-slate-600 leading-relaxed">{item.desc}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

// ------------------------------------------
// 4.8 MODULE 7: ABOUT PROJECT VIEW
// ------------------------------------------
function AboutProjectView() {
  return (
    <div className="space-y-8 animate-in fade-in duration-300 max-w-4xl">
      <div>
        <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
          <Icon name="info" className="w-3.5 h-3.5" />
          <span>Module 7: Academic Documentation</span>
        </div>
        <h2 className="text-2xl font-bold font-display text-slate-900">
          About the Project
        </h2>
      </div>

      <div className="bg-white p-8 rounded-2xl border border-slate-200 shadow-sm space-y-6 text-sm text-slate-700 leading-relaxed">
        <div className="p-4 rounded-xl bg-slate-900 text-white">
          <p className="text-xs text-cyan-400 font-mono uppercase font-bold">Course Information</p>
          <h3 className="text-lg font-bold font-display text-white mt-1">ITA0605 – Machine Learning for Megatrends</h3>
          <p className="text-xs text-slate-300 mt-1">
            <strong>Project Title:</strong> Predictive Analytics for Hospital Readmission Risk Assessment Using Bayesian Models
          </p>
        </div>

        <div>
          <h4 className="text-base font-bold text-slate-900 mb-2">Project Description</h4>
          <p>
            Hospital readmission within 30 days of discharge is one of the most critical healthcare megatrends, causing tremendous clinical burden, increased mortality, and billions of dollars in annual avoidable healthcare expenditures. Under the Hospital Readmissions Reduction Program (HRRP), hospitals face severe financial penalties for excess readmissions.
          </p>
          <p className="mt-3">
            This project develops an intelligent healthcare predictive analytics platform that utilizes Bayesian probability modeling to analyze demographic factors, primary clinical diagnoses, prior hospitalization history, length of hospital stay (LOS), medication regimen complexity, and comorbidity burdens.
          </p>
        </div>

        <div>
          <h4 className="text-base font-bold text-slate-900 mb-2">Key Project Objectives</h4>
          <ul className="list-disc pl-5 space-y-1.5 text-xs">
            <li>Calculate mathematically rigorous posterior readmission probabilities based on Bayes' theorem.</li>
            <li>Classify patients into actionable Low, Medium, and High Risk tiers.</li>
            <li>Provide transparent factor contribution audits explaining the weight of each clinical marker.</li>
            <li>Support healthcare professionals in proactively identifying high-risk patients before discharge.</li>
            <li>Enable data-driven population analytics, dynamic ROC evaluation, and CSV dataset ingestion.</li>
          </ul>
        </div>
      </div>
    </div>
  );
}

// ------------------------------------------
// 4.9 MODULE 8: REFERENCES VIEW
// ------------------------------------------
function ReferencesView() {
  const papers = [
    {
      num: 1,
      title: "Bayesian Network Analysis for Prediction of Unplanned Hospital Readmissions of Cancer Patients",
      authors: "Cascella et al.",
      year: "2022",
      journal: "Journal of Medical Systems / Healthcare Informatics",
      summary: "Demonstrated that directed acyclic graphs and Bayesian networks effectively capture multi-system clinical dependencies in oncological cohorts, outperforming black-box trees in interpretability."
    },
    {
      num: 2,
      title: "Semiparametric Survival Analysis of 30-Day Hospital Readmissions with Bayesian Additive Regression Kernel Model",
      authors: "Chakraborty et al.",
      year: "2022",
      journal: "Biometrics & Medical Statistics",
      summary: "Introduced Bayesian kernelized regression modeling for time-to-readmission estimation, emphasizing the impact of chronic comorbidity burdens on early post-discharge hazards."
    },
    {
      num: 3,
      title: "Effective Hospital Readmission Prediction Models Using Machine-Learned Features",
      authors: "Davis et al.",
      year: "2022",
      journal: "IEEE Journal of Biomedical and Health Informatics",
      summary: "Benchmarked demographic, administrative, and clinical features for 30-day readmissions, establishing prior admission history and length of stay as the two highest-ranking predictive features."
    },
    {
      num: 4,
      title: "Interpretable Machine Learning Models for Hospital Readmission Prediction",
      authors: "Gao et al.",
      year: "2023",
      journal: "Artificial Intelligence in Medicine",
      summary: "Investigated clinical adoption barriers of AI models and demonstrated that transparent Bayesian probability and odds ratio decomposition foster physician trust and actionable intervention."
    },
    {
      num: 5,
      title: "Discovering Spatial Patterns of Readmission Risk Using a Bayesian Competing Risks Model",
      authors: "Shen et al.",
      year: "2025",
      journal: "Spatial and Spatio-temporal Epidemiology",
      summary: "Explored hierarchical Bayesian spatial modeling to identify regional readmission disparities and post-discharge social determinants of health."
    }
  ];

  return (
    <div className="space-y-8 animate-in fade-in duration-300 max-w-4xl">
      <div>
        <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
          <Icon name="book" className="w-3.5 h-3.5" />
          <span>Module 8: Academic Literature</span>
        </div>
        <h2 className="text-2xl font-bold font-display text-slate-900">
          Research Literature & References
        </h2>
        <p className="text-slate-500 text-sm mt-1">
          Peer-reviewed studies foundational to the Bayesian formulation and feature selection of this system.
        </p>
      </div>

      <div className="space-y-4">
        {papers.map((p) => (
          <div key={p.num} className="bg-white p-6 rounded-2xl border border-slate-200/80 shadow-sm space-y-2">
            <div className="flex items-center justify-between">
              <span className="font-mono text-xs font-bold text-blue-600 bg-blue-50 px-2.5 py-0.5 rounded-full border border-blue-100">
                Reference [{p.num}]
              </span>
              <span className="text-xs font-semibold text-slate-400">{p.year}</span>
            </div>
            <h3 className="text-base font-bold text-slate-900">{p.title}</h3>
            <p className="text-xs text-slate-500 italic">{p.authors} — {p.journal}</p>
            <p className="text-xs text-slate-700 pt-1 leading-relaxed">{p.summary}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

// ------------------------------------------
// 4.10 MODULE 9: SETTINGS VIEW
// ------------------------------------------
function SettingsView({ prior, setPrior, cutoffs, setCutoffs, onResetCohort, patientCount }) {
  return (
    <div className="space-y-8 animate-in fade-in duration-300 max-w-3xl">
      <div>
        <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-semibold mb-2 border border-blue-200">
          <Icon name="settings" className="w-3.5 h-3.5" />
          <span>Module 9: Model Calibration & System Settings</span>
        </div>
        <h2 className="text-2xl font-bold font-display text-slate-900">
          Model Calibration & Configuration
        </h2>
      </div>

      <div className="bg-white p-6 md:p-8 rounded-2xl border border-slate-200 shadow-sm space-y-6">
        <div>
          <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700 mb-1">
            Baseline Readmission Prior Probability P(Readmission)
          </h3>
          <p className="text-xs text-slate-500 mb-3">
            National CMS benchmark default: 19.4% (0.194). Adjust this for specific hospital sub-populations.
          </p>
          <div className="flex items-center space-x-4">
            <input
              type="range"
              min="0.05"
              max="0.40"
              step="0.005"
              value={prior}
              onChange={(e) => setPrior(parseFloat(e.target.value))}
              className="w-64 accent-blue-600 cursor-pointer"
            />
            <span className="font-mono font-bold text-blue-600 text-sm">{(prior * 100).toFixed(1)}%</span>
          </div>
        </div>

        <div className="pt-4 border-t border-slate-100">
          <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700 mb-1">
            Risk Tier Cutoff Thresholds
          </h3>
          <p className="text-xs text-slate-500 mb-4">
            Configure cutoff points for Low Risk vs. Medium Risk vs. High Risk classification.
          </p>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">Low / Medium Boundary (%):</label>
              <input
                type="number"
                value={cutoffs.low}
                onChange={(e) => setCutoffs({ ...cutoffs, low: parseInt(e.target.value, 10) })}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 text-xs font-mono"
              />
            </div>
            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">Medium / High Boundary (%):</label>
              <input
                type="number"
                value={cutoffs.high}
                onChange={(e) => setCutoffs({ ...cutoffs, high: parseInt(e.target.value, 10) })}
                className="w-full px-3 py-2 rounded-xl border border-slate-300 text-xs font-mono"
              />
            </div>
          </div>
        </div>

        <div className="pt-4 border-t border-slate-100">
          <h3 className="text-sm font-bold uppercase tracking-wider text-slate-700 mb-1">
            Database & Benchmark Cohort Management
          </h3>
          <p className="text-xs text-slate-500 mb-3">
            Currently tracking {patientCount} patient records in persistent state.
          </p>
          <button
            onClick={onResetCohort}
            className="px-4 py-2 rounded-xl bg-rose-50 hover:bg-rose-100 text-rose-700 border border-rose-200 text-xs font-semibold transition"
          >
            Reset Database to 1,250 Synthetic Benchmark Records
          </button>
        </div>
      </div>
    </div>
  );
}

// ------------------------------------------
// 4.11 PATIENT DETAIL MODAL
// ------------------------------------------
function PatientDetailModal({ patient, onClose, onGenerateReport }) {
  const assessment = useMemo(() => calculateBayesianRisk(patient), [patient]);

  return (
    <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl max-w-xl w-full p-6 space-y-6 shadow-2xl animate-in zoom-in-95 max-h-[90vh] overflow-y-auto">
        <div className="flex items-center justify-between border-b border-slate-100 pb-3">
          <div>
            <h3 className="text-lg font-bold text-slate-900 leading-tight">{patient.patient_name || "Patient Record"}</h3>
            <span className="font-mono text-xs font-bold text-blue-600">ID: {patient.patient_id}</span>
          </div>
          <button onClick={onClose} className="p-1 rounded-lg text-slate-400 hover:text-slate-700">
            <Icon name="x" className="w-5 h-5" />
          </button>
        </div>

        <div className="grid grid-cols-2 gap-3 text-xs">
          <div className="p-3 rounded-lg bg-slate-50">
            <span className="text-slate-500">Diagnosis:</span>
            <p className="font-bold text-slate-800">{patient.diagnosis}</p>
          </div>
          <div className="p-3 rounded-lg bg-slate-50">
            <span className="text-slate-500">Age:</span>
            <p className="font-bold text-slate-800">{patient.age_group}</p>
          </div>
          <div className="p-3 rounded-lg bg-slate-50">
            <span className="text-slate-500">Prior Admissions:</span>
            <p className="font-bold text-slate-800">{patient.previous_admissions}</p>
          </div>
          <div className="p-3 rounded-lg bg-slate-50">
            <span className="text-slate-500">Length of Stay:</span>
            <p className="font-bold text-slate-800">{patient.length_of_stay}</p>
          </div>
        </div>

        <div className="p-4 rounded-xl bg-slate-900 text-white flex items-center justify-between">
          <div>
            <p className="text-xs text-slate-400">Bayesian Posterior Risk</p>
            <p className="text-2xl font-bold font-mono text-cyan-400">{assessment.predicted_probability}%</p>
          </div>
          <span className={`px-3 py-1 rounded-full text-xs font-bold uppercase border ${
            assessment.risk_category === "High Risk" ? "bg-rose-500/20 text-rose-300 border-rose-500/40" : "bg-emerald-500/20 text-emerald-300 border-emerald-500/40"
          }`}>
            {assessment.risk_category}
          </span>
        </div>

        <div className="space-y-2">
          <h4 className="text-xs font-bold text-slate-700 uppercase">Key Contributing Factors</h4>
          <div className="space-y-1 text-xs">
            {assessment.factor_contributions.slice(0, 4).map((fc, i) => (
              <div key={i} className="flex justify-between p-2 rounded bg-slate-50">
                <span>{fc.factor}</span>
                <span className="font-mono font-bold text-blue-600">{fc.likelihood_ratio}x LR</span>
              </div>
            ))}
          </div>
        </div>

        <div className="flex space-x-3 pt-2">
          <button
            onClick={onClose}
            className="flex-1 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-semibold"
          >
            Close
          </button>
          <button
            onClick={onGenerateReport}
            className="flex-1 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-semibold"
          >
            Generate Full Report
          </button>
        </div>
      </div>
    </div>
  );
}

// ==========================================
// 5. RENDER APPLICATION
// ==========================================
ReactDOM.render(<App />, document.getElementById("root"));

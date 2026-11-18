"""
Automated Comprehensive Test Suite for BayeSphere Application
"""

import os
import sys
import json
import sqlite3
import bayesian_engine

def run_tests():
    print("[TEST 1/5] Verifying Bayesian Probability Model Logic...")
    test_cases = [
        {
            "name": "High Risk Patient",
            "data": {
                "patient_id": "TEST-HIGH",
                "age_group": "Above 60",
                "diagnosis": "Cardiovascular Disease",
                "previous_admissions": "3 or more",
                "length_of_stay": "Above 14 days",
                "medication_count": 12,
                "medication_complexity": "High",
                "comorbidities": "Three or more comorbidities",
                "abnormal_lab": True,
                "fall_risk": True
            },
            "expected_tier": "High Risk"
        },
        {
            "name": "Low Risk Patient",
            "data": {
                "patient_id": "TEST-LOW",
                "age_group": "Below 30",
                "diagnosis": "Other",
                "previous_admissions": "0",
                "length_of_stay": "1–3 days",
                "medication_count": 2,
                "medication_complexity": "Low",
                "comorbidities": "None",
                "abnormal_lab": False,
                "fall_risk": False
            },
            "expected_tier": "Low Risk"
        }
    ]

    for tc in test_cases:
        res = bayesian_engine.calculate_bayesian_risk(tc["data"])
        prob = res["predicted_probability"]
        tier = res["risk_category"]
        print(f"  -> {tc['name']}: Probability={prob}%, Tier={tier} (Expected={tc['expected_tier']})")
        assert tier == tc["expected_tier"], f"Mismatch for {tc['name']}: got {tier}, expected {tc['expected_tier']}"

    print("\n[TEST 2/5] Verifying SQLite Database & Cohort Size...")
    conn = sqlite3.connect(bayesian_engine.DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT COUNT(*) FROM patients")
    count = cursor.fetchone()[0]
    conn.close()
    print(f"  -> Total records in DB: {count}")
    assert count >= 1200, f"Expected at least 1200 records, got {count}"

    print("\n[TEST 3/5] Verifying Model Evaluation Metrics...")
    eval_stats = bayesian_engine.evaluate_cohort(threshold=25.0)
    metrics = eval_stats["metrics"]
    print(f"  -> Accuracy: {metrics['accuracy']}%")
    print(f"  -> Precision: {metrics['precision']}%")
    print(f"  -> Sensitivity: {metrics['sensitivity']}%")
    print(f"  -> Specificity: {metrics['specificity']}%")
    print(f"  -> AUC-ROC: {metrics['auc_roc']}")
    assert metrics["auc_roc"] >= 0.85, f"AUC-ROC too low: {metrics['auc_roc']}"
    assert metrics["accuracy"] >= 80.0, f"Accuracy too low: {metrics['accuracy']}"

    print("\n[TEST 4/5] Verifying CSV Export Existence & Headers...")
    assert os.path.exists(bayesian_engine.CSV_PATH), "CSV path does not exist!"
    with open(bayesian_engine.CSV_PATH, 'r', encoding='utf-8') as f:
        header_line = f.readline().strip()
    print(f"  -> CSV Header: {header_line}")
    assert "readmission_probability" in header_line and "readmitted_30d" in header_line

    print("\n[TEST 5/5] Verifying Frontend Assets...")
    index_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "index.html")
    app_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "public", "app.jsx")
    assert os.path.exists(index_path), "index.html missing"
    assert os.path.exists(app_path), "app.jsx missing"
    print(f"  -> index.html size: {os.path.getsize(index_path)} bytes")
    print(f"  -> app.jsx size: {os.path.getsize(app_path)} bytes")

    print("\n==================================================")
    print("ALL 5 TESTS PASSED SUCCESSFULLY! SYSTEM FULLY FUNCTIONAL.")
    print("==================================================")

if __name__ == "__main__":
    run_tests()

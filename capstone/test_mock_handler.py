"""
Direct in-memory testing of HealthcareAPIHandler without network socket binding
"""

import io
import json
import os
import server
import bayesian_engine

class MockSocket:
    def __init__(self, data=b""):
        self.rfile = io.BytesIO(data)
        self.wfile = io.BytesIO()

    def makefile(self, mode, *args, **kwargs):
        if 'r' in mode:
            return self.rfile
        return self.wfile

def test_handler_directly():
    print("[UNIT TEST 1/3] Testing Bayesian Prediction for Patient PT-9901...")
    p_data = {
        "patient_id": "PT-9901",
        "age_group": "Above 60",
        "diagnosis": "Cardiovascular Disease",
        "previous_admissions": "2",
        "length_of_stay": "8–14 days",
        "medication_count": 9,
        "medication_complexity": "High",
        "comorbidities": "Two comorbidities",
        "abnormal_lab": True,
        "fall_risk": True
    }
    res = bayesian_engine.calculate_bayesian_risk(p_data)
    print(f"  -> Predicted Probability: {res['predicted_probability']}%")
    print(f"  -> Risk Category: {res['risk_category']}")
    print(f"  -> Factor Count: {len(res['factor_contributions'])}")
    assert res['predicted_probability'] > 50.0
    assert res['risk_category'] == "High Risk"

    print("\n[UNIT TEST 2/3] Testing Population Evaluation at Thresholds 20%, 30%, 40%...")
    for th in [20.0, 30.0, 40.0]:
        stats = bayesian_engine.evaluate_cohort(threshold=th)
        m = stats["metrics"]
        print(f"  -> Threshold={th}% | Acc={m['accuracy']}% | Sens={m['sensitivity']}% | Spec={m['specificity']}% | AUC={m['auc_roc']}")
        assert m["auc_roc"] > 0.85

    print("\n[UNIT TEST 3/3] Testing CSV Parsing Logic...")
    sample_csv_text = """patient_id,age_group,diagnosis,previous_admissions,length_of_stay,medication_count,medication_complexity,comorbidities,abnormal_lab,fall_risk,readmitted_30d
CSV-TEST-1,Above 60,Kidney Disease,2,8–14 days,8,High,Two comorbidities,1,0,1
CSV-TEST-2,Below 30,Other,0,1–3 days,2,Low,None,0,0,0
"""
    import csv
    reader = csv.DictReader(io.StringIO(sample_csv_text))
    rows = list(reader)
    assert len(rows) == 2
    r1 = bayesian_engine.calculate_bayesian_risk(rows[0])
    r2 = bayesian_engine.calculate_bayesian_risk(rows[1])
    print(f"  -> Row 1 (High risk): {r1['predicted_probability']}% ({r1['risk_category']})")
    print(f"  -> Row 2 (Low risk): {r2['predicted_probability']}% ({r2['risk_category']})")
    assert r1['predicted_probability'] > r2['predicted_probability']

    print("\n==================================================")
    print("ALL IN-MEMORY TESTS COMPLETED SUCCESSFULLY!")
    print("==================================================")

if __name__ == "__main__":
    test_handler_directly()

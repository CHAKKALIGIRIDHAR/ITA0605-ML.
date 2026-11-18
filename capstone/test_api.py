"""
Test REST API Server Endpoints
"""

import threading
import time
import urllib.request
import json
import os
import server

def run_api_tests():
    # Start server in background thread
    server.bayesian_engine.init_database()
    httpd = server.socketserver.TCPServer(("", 8008), server.HealthcareAPIHandler)
    server_thread = threading.Thread(target=httpd.serve_forever, daemon=True)
    server_thread.start()
    time.sleep(0.5)

    base_url = "http://localhost:8008"
    
    print("[API TEST 1/4] Testing GET /api/priors...")
    req = urllib.request.urlopen(f"{base_url}/api/priors")
    data = json.loads(req.read().decode('utf-8'))
    print("  -> Prior:", data["default_prior"])
    assert data["default_prior"] == 0.194

    print("\n[API TEST 2/4] Testing GET /api/patients?limit=5...")
    req = urllib.request.urlopen(f"{base_url}/api/patients?limit=5")
    data = json.loads(req.read().decode('utf-8'))
    print("  -> Returned patients:", len(data["patients"]))
    assert len(data["patients"]) == 5

    print("\n[API TEST 3/4] Testing GET /api/analytics...")
    req = urllib.request.urlopen(f"{base_url}/api/analytics")
    data = json.loads(req.read().decode('utf-8'))
    print("  -> Total patients in analytics:", data["total_patients"])
    print("  -> AUC-ROC:", data["metrics"]["auc_roc"])
    assert data["total_patients"] >= 1200

    print("\n[API TEST 4/4] Testing POST /api/assess...")
    req_body = json.dumps({
        "patient_id": "TEST-API-01",
        "age_group": "Above 60",
        "diagnosis": "Cardiovascular Disease",
        "previous_admissions": "2",
        "length_of_stay": "8–14 days",
        "medication_count": 8,
        "medication_complexity": "High",
        "comorbidities": "Two comorbidities",
        "abnormal_lab": True,
        "fall_risk": True,
        "save_to_database": True
    }).encode('utf-8')
    req = urllib.request.Request(f"{base_url}/api/assess", data=req_body, headers={'Content-Type': 'application/json'}, method='POST')
    resp = urllib.request.urlopen(req)
    data = json.loads(resp.read().decode('utf-8'))
    print(f"  -> Assessed probability: {data['predicted_probability']}%, Risk: {data['risk_category']}, Saved: {data.get('saved')}")
    assert data["predicted_probability"] > 40.0
    assert data.get("saved") == True

    httpd.shutdown()
    httpd.server_close()
    print("\nALL API ENDPOINTS TESTED SUCCESSFULLY AND VERIFIED!")

if __name__ == "__main__":
    run_api_tests()

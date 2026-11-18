"""
Production-grade HTTP Server & REST API for Hospital Readmission Bayesian Analytics
Course: ITA0605 - Machine Learning for Megatrends
"""

import http.server
import socketserver
import json
import urllib.parse
import os
import sqlite3
import csv
import io
import sys
from datetime import datetime

# Import Bayesian Engine
import bayesian_engine

PORT = 8000
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
PUBLIC_DIR = os.path.join(BASE_DIR, "public")
DB_PATH = os.path.join(DATA_DIR, "hospital_readmission.db")


class HealthcareAPIHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=BASE_DIR, **kwargs)

    def end_headers(self):
        # Enable CORS and disable aggressive caching for development
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, DELETE, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200, "OK")
        self.end_headers()

    def send_json(self, data, status_code=200):
        response_bytes = json.dumps(data, indent=2).encode('utf-8')
        self.send_response(status_code)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(response_bytes)))
        self.end_headers()
        self.wfile.write(response_bytes)

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path
        params = urllib.parse.parse_qs(parsed.query)

        # Static routing fallback to index.html for SPA
        if path == "/" or path == "":
            self.path = "/index.html"
            return super().do_GET()

        # Download sample CSV
        if path == "/api/download-sample-csv":
            csv_path = os.path.join(DATA_DIR, "synthetic_readmission_cohort_1250.csv")
            if os.path.exists(csv_path):
                with open(csv_path, 'rb') as f:
                    content = f.read()
                self.send_response(200)
                self.send_header('Content-Type', 'text/csv')
                self.send_header('Content-Disposition', 'attachment; filename="hospital_readmission_sample_cohort.csv"')
                self.send_header('Content-Length', str(len(content)))
                self.end_headers()
                self.wfile.write(content)
                return
            else:
                self.send_json({"error": "Sample CSV not found"}, 404)
                return

        # API: Model Priors and Likelihoods
        if path == "/api/priors":
            self.send_json({
                "default_prior": bayesian_engine.DEFAULT_PRIOR,
                "likelihoods": bayesian_engine.LIKELIHOODS,
                "project_title": "Predictive Analytics for Hospital Readmission Risk Assessment Using Bayesian Models",
                "course": "ITA0605 – Machine Learning for Megatrends"
            })
            return

        # API: Population Analytics & Evaluation
        if path == "/api/analytics":
            try:
                threshold = float(params.get("threshold", [25.0])[0])
            except ValueError:
                threshold = 25.0
            stats = bayesian_engine.evaluate_cohort(threshold=threshold)
            self.send_json(stats)
            return

        # API: Get Patient Records
        if path == "/api/patients":
            search = params.get("search", [""])[0].lower()
            risk_filter = params.get("risk", ["All"])[0]
            diag_filter = params.get("diagnosis", ["All"])[0]
            sort_by = params.get("sort", ["id_desc"])[0]
            limit = int(params.get("limit", [100])[0])
            offset = int(params.get("offset", [0])[0])

            conn = sqlite3.connect(DB_PATH)
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()

            query = "SELECT * FROM patients WHERE 1=1"
            query_params = []

            if search:
                query += " AND (LOWER(patient_id) LIKE ? OR LOWER(patient_name) LIKE ? OR LOWER(diagnosis) LIKE ?)"
                query_params.extend([f"%{search}%", f"%{search}%", f"%{search}%"])

            if risk_filter != "All":
                query += " AND risk_category = ?"
                query_params.append(risk_filter)

            if diag_filter != "All":
                query += " AND diagnosis = ?"
                query_params.append(diag_filter)

            if sort_by == "prob_desc":
                query += " ORDER BY readmission_probability DESC"
            elif sort_by == "prob_asc":
                query += " ORDER BY readmission_probability ASC"
            elif sort_by == "date_desc":
                query += " ORDER BY assessment_date DESC"
            elif sort_by == "id_asc":
                query += " ORDER BY id ASC"
            else:
                query += " ORDER BY id DESC"

            # Count total matching
            count_query = query.replace("SELECT *", "SELECT COUNT(*)", 1)
            # Remove order by for count
            if " ORDER BY" in count_query:
                count_query = count_query.split(" ORDER BY")[0]
            cursor.execute(count_query, query_params)
            total_matching = cursor.fetchone()[0]

            query += f" LIMIT {limit} OFFSET {offset}"
            cursor.execute(query, query_params)
            rows = [dict(r) for r in cursor.fetchall()]
            conn.close()

            self.send_json({
                "total": total_matching,
                "limit": limit,
                "offset": offset,
                "patients": rows
            })
            return

        # Specific Patient Record
        if path.startswith("/api/patients/"):
            patient_id = path.replace("/api/patients/", "").strip()
            conn = sqlite3.connect(DB_PATH)
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM patients WHERE patient_id = ?", (patient_id,))
            row = cursor.fetchone()
            conn.close()

            if row:
                p_dict = dict(row)
                # Compute detailed Bayesian steps for this record
                assessment = bayesian_engine.calculate_bayesian_risk({
                    "patient_id": p_dict["patient_id"],
                    "age_group": p_dict["age_group"],
                    "diagnosis": p_dict["diagnosis"],
                    "previous_admissions": p_dict["previous_admissions"],
                    "length_of_stay": p_dict["length_of_stay"],
                    "medication_count": p_dict["medication_count"],
                    "medication_complexity": p_dict["medication_complexity"],
                    "comorbidities": p_dict["comorbidities"],
                    "abnormal_lab": bool(p_dict["abnormal_lab"]),
                    "fall_risk": bool(p_dict["fall_risk"])
                })
                p_dict["assessment_details"] = assessment
                self.send_json(p_dict)
            else:
                self.send_json({"error": "Patient not found"}, 404)
            return

        # Serve static files as default
        super().do_GET()

    def do_POST(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path

        content_length = int(self.headers.get('Content-Length', 0))
        body = self.rfile.read(content_length)

        # Parse JSON payload
        try:
            payload = json.loads(body.decode('utf-8')) if body else {}
        except Exception:
            payload = {}

        # API: Calculate Bayesian Risk
        if path == "/api/assess":
            custom_prior = payload.get("custom_prior")
            result = bayesian_engine.calculate_bayesian_risk(payload, custom_prior=custom_prior)

            # Auto-save to database if requested
            if payload.get("save_to_database", False):
                try:
                    conn = sqlite3.connect(DB_PATH)
                    cursor = conn.cursor()
                    cursor.execute("""
                    INSERT OR REPLACE INTO patients (
                        patient_id, patient_name, age_group, diagnosis, previous_admissions, length_of_stay,
                        medication_count, medication_complexity, comorbidities, abnormal_lab,
                        fall_risk, readmission_probability, risk_category, assessment_date, notes
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, (
                        result["patient_id"],
                        payload.get("patient_name", result.get("patient_name", "Eleanor Vance")),
                        payload.get("age_group", "46–60"),
                        payload.get("diagnosis", "Diabetes"),
                        str(payload.get("previous_admissions", "1")),
                        payload.get("length_of_stay", "4–7 days"),
                        int(payload.get("medication_count", 6)),
                        payload.get("medication_complexity", "Medium"),
                        payload.get("comorbidities", "One comorbidity"),
                        1 if payload.get("abnormal_lab", False) else 0,
                        1 if payload.get("fall_risk", False) else 0,
                        result["predicted_probability"],
                        result["risk_category"],
                        datetime.now().strftime("%Y-%m-%d"),
                        payload.get("notes", "Assessed via web calculator")
                    ))
                    conn.commit()
                    conn.close()
                    result["saved"] = True
                except Exception as e:
                    result["saved"] = False
                    result["save_error"] = str(e)

            self.send_json(result)
            return

        # API: Save Patient Record directly
        if path == "/api/patients":
            p = payload
            assessment = bayesian_engine.calculate_bayesian_risk(p)
            try:
                conn = sqlite3.connect(DB_PATH)
                cursor = conn.cursor()
                cursor.execute("""
                INSERT OR REPLACE INTO patients (
                    patient_id, patient_name, age_group, diagnosis, previous_admissions, length_of_stay,
                    medication_count, medication_complexity, comorbidities, abnormal_lab,
                    fall_risk, readmission_probability, risk_category, assessment_date, notes
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, (
                    p.get("patient_id", assessment["patient_id"]),
                    p.get("patient_name", assessment.get("patient_name", "Eleanor Vance")),
                    p.get("age_group", "46–60"),
                    p.get("diagnosis", "Diabetes"),
                    str(p.get("previous_admissions", "1")),
                    p.get("length_of_stay", "4–7 days"),
                    int(p.get("medication_count", 6)),
                    p.get("medication_complexity", "Medium"),
                    p.get("comorbidities", "One comorbidity"),
                    1 if p.get("abnormal_lab", False) else 0,
                    1 if p.get("fall_risk", False) else 0,
                    assessment["predicted_probability"],
                    assessment["risk_category"],
                    p.get("assessment_date", datetime.now().strftime("%Y-%m-%d")),
                    p.get("notes", "Direct assessment save")
                ))
                conn.commit()
                conn.close()
                self.send_json({"success": True, "patient_id": assessment["patient_id"], "risk_category": assessment["risk_category"], "probability": assessment["predicted_probability"]})
            except Exception as e:
                self.send_json({"error": str(e)}, 500)
            return

        # API: Reset Database to default 1250 cohort
        if path == "/api/reset":
            if os.path.exists(DB_PATH):
                os.remove(DB_PATH)
            bayesian_engine.init_database()
            stats = bayesian_engine.evaluate_cohort()
            self.send_json({"success": True, "message": "Database reset to 1250 synthetic patients.", "stats": stats})
            return

        # API: Upload CSV Dataset
        if path == "/api/upload-csv":
            csv_text = payload.get("csv_content", "")
            if not csv_text:
                self.send_json({"error": "No CSV content provided."}, 400)
                return

            try:
                reader = csv.DictReader(io.StringIO(csv_text))
                required_cols = {"age_group", "diagnosis", "previous_admissions", "length_of_stay"}
                fieldnames = set(reader.fieldnames or [])

                if not required_cols.issubset(fieldnames):
                    missing = required_cols - fieldnames
                    self.send_json({
                        "error": f"CSV is missing required clinical columns: {', '.join(missing)}",
                        "expected_columns": ["patient_id", "age_group", "diagnosis", "previous_admissions", "length_of_stay", "medication_count", "medication_complexity", "comorbidities", "readmitted_30d"]
                    }, 400)
                    return

                new_records = []
                scores = []
                tp, fp, tn, fn = 0, 0, 0, 0
                threshold = 25.0

                for idx, row in enumerate(reader, 1):
                    pid = row.get("patient_id", f"CSV-PT-{idx:04d}")
                    age = row.get("age_group", "46–60")
                    diag = row.get("diagnosis", "Other")
                    prev = str(row.get("previous_admissions", "0"))
                    los = row.get("length_of_stay", "1–3 days")
                    med_c = row.get("medication_complexity", "Medium")
                    com = row.get("comorbidities", "None")
                    
                    try:
                        med_cnt = int(row.get("medication_count", 5))
                    except ValueError:
                        med_cnt = 5
                        
                    ab_lab = row.get("abnormal_lab", "0") in ["1", "true", "True", "yes", "Yes"]
                    f_risk = row.get("fall_risk", "0") in ["1", "true", "True", "yes", "Yes"]

                    res = bayesian_engine.calculate_bayesian_risk({
                        "patient_id": pid,
                        "age_group": age,
                        "diagnosis": diag,
                        "previous_admissions": prev,
                        "length_of_stay": los,
                        "medication_count": med_cnt,
                        "medication_complexity": med_c,
                        "comorbidities": com,
                        "abnormal_lab": ab_lab,
                        "fall_risk": f_risk
                    })

                    actual_readmit = None
                    if "readmitted_30d" in row and row["readmitted_30d"] != "":
                        try:
                            actual_readmit = int(row["readmitted_30d"])
                        except ValueError:
                            actual_readmit = 1 if row["readmitted_30d"].lower() in ["yes", "true"] else 0

                    prob = res["predicted_probability"]
                    risk_cat = res["risk_category"]

                    if actual_readmit is not None:
                        pred = 1 if prob >= threshold else 0
                        scores.append((prob / 100.0, actual_readmit))
                        if pred == 1 and actual_readmit == 1:
                            tp += 1
                        elif pred == 1 and actual_readmit == 0:
                            fp += 1
                        elif pred == 0 and actual_readmit == 0:
                            tn += 1
                        elif pred == 0 and actual_readmit == 1:
                            fn += 1

                    new_records.append((
                        pid, age, diag, prev, los, med_cnt, med_c, com,
                        1 if ab_lab else 0, 1 if f_risk else 0,
                        prob, risk_cat, actual_readmit,
                        datetime.now().strftime("%Y-%m-%d"), "Uploaded from CSV dataset"
                    ))

                # Batch insert into DB
                conn = sqlite3.connect(DB_PATH)
                cursor = conn.cursor()
                cursor.executemany("""
                INSERT OR REPLACE INTO patients (
                    patient_id, age_group, diagnosis, previous_admissions, length_of_stay,
                    medication_count, medication_complexity, comorbidities, abnormal_lab,
                    fall_risk, readmission_probability, risk_category, actual_readmitted,
                    assessment_date, notes
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, new_records)
                conn.commit()
                conn.close()

                # Calculate metrics if actual ground truth provided
                eval_metrics = None
                if scores:
                    total_eval = len(scores)
                    acc = (tp + tn) / total_eval if total_eval > 0 else 0
                    prec = tp / (tp + fp) if (tp + fp) > 0 else 0
                    sens = tp / (tp + fn) if (tp + fn) > 0 else 0
                    spec = tn / (tn + fp) if (tn + fp) > 0 else 0

                    eval_metrics = {
                        "accuracy": round(acc * 100, 2),
                        "precision": round(prec * 100, 2),
                        "sensitivity": round(sens * 100, 2),
                        "specificity": round(spec * 100, 2),
                        "confusion_matrix": {"tp": tp, "fp": fp, "tn": tn, "fn": fn}
                    }

                self.send_json({
                    "success": True,
                    "processed_rows": len(new_records),
                    "labeled_rows": len(scores),
                    "metrics": eval_metrics,
                    "message": f"Successfully parsed and ingested {len(new_records)} patient records."
                })
            except Exception as e:
                self.send_json({"error": f"Failed to process CSV: {str(e)}"}, 500)
            return

        self.send_json({"error": "Endpoint not found"}, 404)

    def do_DELETE(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path

        if path.startswith("/api/patients/"):
            patient_id = path.replace("/api/patients/", "").strip()
            conn = sqlite3.connect(DB_PATH)
            cursor = conn.cursor()
            cursor.execute("DELETE FROM patients WHERE patient_id = ?", (patient_id,))
            deleted = cursor.rowcount
            conn.commit()
            conn.close()

            if deleted > 0:
                self.send_json({"success": True, "message": f"Patient {patient_id} deleted."})
            else:
                self.send_json({"error": "Patient not found"}, 404)
            return

        self.send_json({"error": "Endpoint not found"}, 404)


def run_server():
    bayesian_engine.init_database()
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), HealthcareAPIHandler) as httpd:
        print(f"Hospital Readmission Bayesian Analytics Server active on port {PORT}")
        print(f"Access Web UI at: http://localhost:{PORT}")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server gracefully...")
            httpd.server_close()


if __name__ == "__main__":
    run_server()

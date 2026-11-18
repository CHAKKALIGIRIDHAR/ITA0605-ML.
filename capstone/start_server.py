"""
Launcher for Hospital Readmission Bayesian Analytics Application
ITA0605 - Machine Learning for Megatrends
"""

import webbrowser
import threading
import time
import sys
import os

# Import server
import server

def open_browser():
    time.sleep(1.2)
    url = f"http://localhost:{server.PORT}"
    print(f"\n[BayeSphere] Opening application in default browser: {url}")
    webbrowser.open(url)

if __name__ == "__main__":
    print("=" * 70)
    print(" BAYESPHERE: HOSPITAL READMISSION PREDICTIVE ANALYTICS PLATFORM")
    print(" Course: ITA0605 – Machine Learning for Megatrends")
    print(" Powered by Bayesian Probability Modeling & Naive Bayes Likelihoods")
    print("=" * 70)
    
    # Launch browser thread
    threading.Thread(target=open_browser, daemon=True).start()
    
    # Run HTTP Server
    server.run_server()

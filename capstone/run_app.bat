@echo off
TITLE BayeSphere - Hospital Readmission Risk Analytics (ITA0605)
COLOR 0B
echo ======================================================================
echo    BAYESPHERE: HOSPITAL READMISSION RISK ANALYTICS PLATFORM
echo    Course: ITA0605 - Machine Learning for Megatrends
echo ======================================================================
echo.
echo Starting Bayesian Inference Server on port 8000...
echo.

if exist "C:\Users\HP\AppData\Local\Programs\Python\Python314\python.exe" (
    "C:\Users\HP\AppData\Local\Programs\Python\Python314\python.exe" start_server.py
) else (
    py start_server.py || python start_server.py
)

pause

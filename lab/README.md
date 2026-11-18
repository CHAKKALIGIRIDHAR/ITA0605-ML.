# ITA06 - Machine Learning Lab: 20 Colab-ready notebooks

Each notebook is a complete pipeline: Data Collection -> Data Loading -> Preprocessing -> EDA -> Training -> Evaluation -> Prediction on new data.
No files need uploading; every dataset is generated in code or loaded from scikit-learn.

How to use: open https://colab.research.google.com -> File -> Upload notebook -> pick a .ipynb -> Runtime -> Run all.

| # | Notebook | Topic |
|---|----------|-------|
| 1 | Exp01_FIND_S | FIND-S (most specific hypothesis) |
| 2 | Exp02_Candidate_Elimination | Candidate-Elimination (version space) |
| 3 | Exp03_Decision_Tree_ID3 | ID3 decision tree |
| 4 | Exp04_ANN_Backpropagation | Neural network with backpropagation |
| 5 | Exp05_KNN | K-Nearest Neighbours |
| 6 | Exp06_Naive_Bayes | Naive Bayes + confusion matrix |
| 7 | Exp07_Logistic_Regression | Logistic Regression |
| 8 | Exp08_Linear_Regression | Linear Regression |
| 9 | Exp09_Linear_vs_Polynomial_Regression | Linear vs Polynomial |
| 10 | Exp10_EM_Algorithm | Expectation-Maximization (GMM) |
| 11 | Exp11_Credit_Score_Classification | Credit score classification |
| 12 | Exp12_Iris_KNN | Iris with K-NN |
| 13 | Exp13_Car_Price_Prediction | Car price prediction |
| 14 | Exp14_House_Price_Prediction | House price prediction |
| 15 | Exp15_Iris_Naive_Bayes | Iris with Naive Bayes |
| 16 | Exp16_Compare_Classification_Algorithms | Comparing 8 classifiers |
| 17 | Exp17_Mobile_Price_Prediction | Mobile price prediction |
| 18 | Exp18_Perceptron_Iris | Perceptron on Iris |
| 19 | Exp19_Bank_Loan_Naive_Bayes | Bank loan prediction (Naive Bayes) |
| 20 | Exp20_Future_Sales_Prediction | Future sales prediction |

Note: datasets in Exp 6, 7, 8, 9, 10, 11, 13, 14, 17, 19, 20 are synthetic (generated to mimic well-known public datasets) so the notebooks work offline.
To use a real Kaggle CSV instead, replace the Step 1 / Step 2 cells with pd.read_csv("your_file.csv") and keep the same column names.

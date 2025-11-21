# ⚡ Quick Start Guide

Get everything running in 10 minutes!

## Prerequisites
- Python 3.10+
- Jupyter Notebook
- Flutter SDK
- Git

---

## 🚀 5-Step Quick Start

### Step 1: Download Dataset (2 min)
```bash
# Visit Kaggle and download
https://www.kaggle.com/datasets/lava18/google-play-store-apps

# Place googleplaystore.csv here:
cd summative/linear_regression/
```

### Step 2: Run Notebook (3 min)
```bash
jupyter notebook Untitled1.ipynb
# Click "Run All" or press Shift+Enter through each cell
# Models will be saved to API/saved_model/
```

### Step 3: Start API (2 min)
```bash
cd ../../API
pip install -r requirements.txt
python prediction.py

# Visit: http://localhost:8000/docs
```

### Step 4: Test API (1 min)
In Swagger UI at http://localhost:8000/docs:
- Click POST /predict
- Click "Try it out"
- Use example data
- Click "Execute"
- See prediction!

### Step 5: Run Flutter App (2 min)
```bash
cd ../FlutterApp

# Update API URL in lib/main.dart line 95:
# For Android emulator: http://10.0.2.2:8000/predict
# For iOS simulator: http://localhost:8000/predict

flutter pub get
flutter run
```

---

## 📝 Test Checklist

### Notebook ✅
- [ ] All cells execute without errors
- [ ] Visualizations display
- [ ] Models trained successfully
- [ ] Files saved in API/saved_model/

### API ✅
- [ ] Server starts on port 8000
- [ ] /docs shows Swagger UI
- [ ] /predict accepts test data
- [ ] Validation errors work

### Flutter App ✅
- [ ] App launches
- [ ] Can enter data in all fields
- [ ] Predict button works
- [ ] Shows result or error

---

## 🎯 Sample Test Data

Use this in Swagger UI or Flutter app:

```json
{
  "reviews": 50000,
  "size_mb": 25.5,
  "installs": 1000000,
  "price": 0.0,
  "is_free": 1,
  "category": "GAME"
}
```

Expected result: Rating between 3.5 - 4.5

---

## 🐛 Quick Fixes

### "Model not found"
```bash
# Run notebook first to generate models
cd summative/linear_regression
jupyter notebook Untitled1.ipynb
```

### "Port 8000 already in use"
```bash
# Windows
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:8000 | xargs kill -9
```

### "Flutter package not found"
```bash
cd summative/FlutterApp
flutter clean
flutter pub get
```

### "Connection refused" in Flutter
Check API URL in `lib/main.dart`:
- Android emulator: `http://10.0.2.2:8000/predict`
- iOS simulator: `http://localhost:8000/predict`
- Physical device: `http://YOUR_IP:8000/predict`

---

## 📊 Expected Output

### Notebook
- Dataset shape: (9000+, 6)
- Models trained: 4
- Best model RMSE: < 0.5
- Plots: 10+

### API
- Status: "healthy"
- Model loaded: true
- Endpoints: 4 working

### Flutter App
- Screens: 2
- Input fields: 6
- Prediction: Shows rating 1.0-5.0

---

## 🎥 Ready for Demo?

Before recording:
- [x] Notebook executed
- [x] API deployed
- [x] Flutter app working
- [ ] Camera/mic tested
- [ ] Screen recorder ready

Follow **VIDEO_GUIDE.md** for recording!

---

## 📦 Ready to Submit?

- [ ] Notebook complete
- [ ] API deployed (URL in README)
- [ ] Flutter app tested
- [ ] Video recorded (link in README)
- [ ] GitHub pushed

**Submit**: 
1. ZIP: `git archive -o submission.zip HEAD`
2. GitHub: https://github.com/Sougnabe/linear_regression_model

---

**Need more help?** Check:
- README.md - Complete documentation
- SUBMISSION_CHECKLIST.md - Detailed checklist
- PROJECT_SUMMARY.md - Full overview
- DEPLOYMENT.md - API deployment guide

**Good luck! 🚀**

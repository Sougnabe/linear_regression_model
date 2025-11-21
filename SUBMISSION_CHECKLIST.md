# 🚀 Quick Submission Checklist

This is your step-by-step guide to complete and submit the assignment.

## ✅ Pre-Submission Checklist

### Step 1: Run the Jupyter Notebook
- [ ] Download dataset: https://www.kaggle.com/datasets/lava18/google-play-store-apps
- [ ] Place `googleplaystore.csv` in `summative/linear_regression/`
- [ ] Open `Untitled1.ipynb` in Jupyter
- [ ] Run all cells (this will take a few minutes)
- [ ] Verify models are saved in `API/saved_model/`
- [ ] Check that loss curves and scatter plots are displayed

### Step 2: Test API Locally
- [ ] Navigate to `summative/API/`
- [ ] Install dependencies: `pip install -r requirements.txt`
- [ ] Run API: `python prediction.py`
- [ ] Open browser: http://localhost:8000/docs
- [ ] Test `/predict` endpoint with sample data
- [ ] Verify all endpoints work (/, /health, /model-info)

### Step 3: Deploy API
- [ ] Create account on Render.com
- [ ] Deploy from GitHub repository
- [ ] Configure as per `API/DEPLOYMENT.md`
- [ ] Copy deployed URL
- [ ] Test deployed API at: `https://your-app.onrender.com/docs`
- [ ] Update README.md with actual API URL

### Step 4: Update and Test Flutter App
- [ ] Open `FlutterApp/lib/main.dart`
- [ ] Update `apiUrl` variable (line 95) with deployed URL
- [ ] Run: `cd FlutterApp && flutter pub get`
- [ ] Test on emulator: `flutter run`
- [ ] Verify app makes successful predictions
- [ ] Test validation (try invalid inputs)

### Step 5: Update README
- [ ] Update main README.md with deployed API URL
- [ ] Add YouTube video link (after recording)
- [ ] Verify all instructions are accurate
- [ ] Check that mission statement is <= 4 lines

### Step 6: Record Demo Video (≤5 minutes)
- [ ] **CAMERA ON** throughout video
- [ ] Show notebook with explanations (~2 min):
  - Model performance comparison
  - Loss curves interpretation
  - Dataset impact discussion
  - Model selection justification
- [ ] Demo Flutter app making predictions (~1.5 min):
  - Show input screen
  - Make 2-3 predictions
  - Show API call in code
- [ ] Demo Swagger UI (~1.5 min):
  - Test valid prediction
  - Test invalid data type
  - Test invalid range
  - Show model-info endpoint
- [ ] Upload to YouTube (public or unlisted)
- [ ] Copy video link

### Step 7: Final Repository Check
- [ ] All files committed to GitHub
- [ ] README.md is complete with:
  - [x] Mission (4 lines)
  - [ ] Dataset source
  - [ ] API URL (deployed)
  - [ ] Flutter run instructions
  - [ ] YouTube video link
- [ ] Folder structure matches requirements:
  ```
  summative/
    ├── linear_regression/
    │   └── Untitled1.ipynb
    ├── API/
    │   ├── prediction.py
    │   └── requirements.txt
    └── FlutterApp/
        └── lib/main.dart
  ```

### Step 8: Submit to Canvas
- [ ] **Attempt 1**: Upload ZIP of repository
  - `git archive -o submission.zip HEAD`
- [ ] **Attempt 2**: Submit GitHub repository URL
  - https://github.com/Sougnabe/linear_regression_model

---

## 📋 What to Test Before Submitting

### Notebook Tests
1. ✅ All cells run without errors
2. ✅ Visualizations are generated:
   - Rating distribution
   - Correlation heatmap
   - Scatter plots (4 subplots)
   - Loss curves (train/test)
   - Actual vs Predicted (4 models)
3. ✅ Models trained:
   - SGD Linear Regression (with gradient descent loop)
   - Linear Regression
   - Decision Tree
   - Random Forest
4. ✅ Best model saved to `API/saved_model/`

### API Tests
1. ✅ GET `/` returns API info
2. ✅ GET `/health` shows "healthy" status
3. ✅ GET `/model-info` returns model details
4. ✅ POST `/predict` with valid data returns prediction
5. ✅ POST `/predict` with invalid type returns 422 error
6. ✅ POST `/predict` with out-of-range returns 422 error
7. ✅ Swagger UI accessible at `/docs`

### Flutter App Tests
1. ✅ App launches without errors
2. ✅ Home screen displays correctly
3. ✅ Navigation to prediction screen works
4. ✅ All 6 input fields present:
   - Reviews (integer)
   - Size MB (float)
   - Installs (integer)
   - Price (float)
   - Type (dropdown)
   - Category (text)
5. ✅ Predict button works
6. ✅ Loading indicator shows during API call
7. ✅ Success message displays prediction
8. ✅ Error messages show for validation failures
9. ✅ API call executes successfully

---

## 🎯 Grading Rubric Quick Check

### Linear Regression Dataset (5 pts)
- [x] Use case is NOT generic ✅ (Mobile app ratings)
- [x] Dataset is RICH ✅ (10,000+ apps, multiple features)
- [x] Description in README ✅
- [x] 2+ meaningful visualizations ✅

### Linear Regression Models (10 pts)
- [x] Linear regression model ✅ (SGD + standard)
- [x] Random Forest model ✅
- [x] Decision Trees model ✅
- [x] Saves best model ✅
- [x] Prediction code for one data point ✅
- [x] Scatter plot with regression line ✅

### API (10 pts)
- [x] API endpoint for prediction ✅
- [ ] Public URL + Swagger UI ⚠️ (deploy to get)
- [x] CORS middleware ✅
- [x] Pydantic constraints ✅
- [x] Each variable has datatype ✅

### Mobile App (5 pts)
- [x] Relevant prediction page ✅
- [x] Text boxes match input count (6) ✅
- [x] Button ✅
- [x] Output display field ✅

### Video Demo (10 pts)
- [ ] Mobile app demo ⚠️ (record)
- [ ] Swagger UI tests ⚠️ (record)
- [ ] Camera ON ⚠️ (record)
- [ ] Model explanation ⚠️ (record)
- [ ] ≤5 minutes ⚠️ (record)

**Current Status**: 30/40 points ready (75%)
**To Complete**: Deploy API + Record video = 10 points

---

## 🎬 Video Recording Script

### Introduction (15 seconds)
"Hello, I'm [Your Name]. This is my mobile app rating prediction project using linear regression and machine learning."

### Part 1: Notebook Walkthrough (2 minutes)
1. **Open Jupyter Notebook**
   - "I'm using Google Play Store dataset with 10,000+ apps"
   - "Here's the correlation heatmap showing relationships between features"
   
2. **Show Models**
   - "I trained 4 models: SGD Linear Regression with gradient descent..."
   - "Here's the loss curve showing convergence over 200 epochs"
   - "This scatter plot shows actual vs predicted ratings"
   
3. **Performance**
   - "Random Forest achieved the best RMSE of X.XX"
   - "The dataset's large size and diverse features helped model performance"
   - "I selected Random Forest because it handles non-linear relationships well"

### Part 2: Flutter App Demo (1.5 minutes)
1. **Show App**
   - "This is the mobile app with 6 input fields matching our model features"
   - "Let me predict the rating for a popular free game..."
   - [Enter data and click Predict]
   - "The app predicts a rating of 4.25 stars"

2. **Show Code**
   - "Here's the API call in main.dart using HTTP POST"

### Part 3: Swagger UI Demo (1.5 minutes)
1. **Test Valid Prediction**
   - "Testing with valid game data... Rating: 4.25"
   
2. **Test Data Type Validation**
   - "Now testing with string instead of number... Error 422"
   
3. **Test Range Validation**
   - "Testing with reviews exceeding limit... Error 422"

### Conclusion (15 seconds)
"All components work: trained models, deployed API, and mobile app. Thank you!"

---

## 📞 Troubleshooting

### Issue: Notebook cells fail
**Solution**: Install dependencies: `pip install pandas numpy matplotlib seaborn scikit-learn joblib`

### Issue: Model files not found
**Solution**: Run all notebook cells to generate models in `API/saved_model/`

### Issue: API returns 503 error
**Solution**: Ensure model files are present and accessible

### Issue: Flutter app connection error
**Solution**: 
- Check API URL in main.dart
- For Android emulator: use `10.0.2.2:8000`
- For deployed API: use actual HTTPS URL

### Issue: CORS error in Flutter
**Solution**: CORS middleware is already configured in `prediction.py`

---

## 🎉 Ready to Submit?

If all checkboxes above are checked:
1. Create ZIP: `git archive -o submission.zip HEAD`
2. Upload to Canvas (Attempt 1)
3. Submit GitHub link (Attempt 2): https://github.com/Sougnabe/linear_regression_model

**Good luck! 🚀**

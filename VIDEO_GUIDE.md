# 🎥 Video Demo Guide (5 Minutes Maximum)

## Pre-Recording Checklist
- [ ] Jupyter notebook with all cells executed
- [ ] API deployed and accessible
- [ ] Flutter app running on emulator/device
- [ ] Swagger UI open in browser
- [ ] Camera and microphone working
- [ ] Screen recording software ready

---

## 🎬 Recording Timeline

### ⏱️ 0:00-0:15 - Introduction (15 seconds)
**Camera**: ON
**Screen**: Your face or split screen

**Script**:
> "Hello, I'm [Your Name]. This is my Mobile App Rating Prediction project. I'll demonstrate the complete machine learning workflow: from data analysis and model training to API deployment and mobile app integration."

---

### ⏱️ 0:15-2:15 - Notebook Demonstration (2 minutes)

#### 0:15-0:45 - Dataset and Problem (30 seconds)
**Screen**: Jupyter notebook - first cells

**What to show**:
- Cell 1: Dataset loading (mention Google Play Store)
- Cell 2: Data info showing 10,000+ apps

**Script**:
> "I'm using the Google Play Store Apps dataset with over 10,000 applications. The target variable is the app rating from 1 to 5 stars. This is a regression problem, not classification."

#### 0:45-1:15 - Visualizations (30 seconds)
**Screen**: Scroll through visualization cells

**What to show**:
- Cell 4: Distribution plots
- Cell 5: Correlation heatmap

**Script**:
> "Here's the rating distribution showing most apps cluster around 4 stars. The correlation heatmap reveals that reviews and installs have moderate positive correlation with ratings. These insights guided my feature selection."

#### 1:15-1:45 - Model Training (30 seconds)
**Screen**: Gradient descent and loss curves

**What to show**:
- Cell 9: SGD training loop code
- Cell 10: Loss curves plot

**Script**:
> "I implemented gradient descent using SGDRegressor with 200 epochs. The loss curves show smooth convergence with train and test losses decreasing together, indicating good learning without overfitting."

#### 1:45-2:15 - Model Comparison (30 seconds)
**Screen**: Model evaluation and scatter plots

**What to show**:
- Cell 12: Model evaluation metrics
- Cell 13: Actual vs Predicted scatter plots

**Script**:
> "I trained four models: SGD Linear Regression, standard Linear Regression, Decision Tree, and Random Forest. Random Forest achieved the best RMSE of [X.XX], explaining [XX]% of variance. I selected it because it handles non-linear feature interactions well and the large dataset prevents overfitting."

---

### ⏱️ 2:15-3:30 - Mobile App Demo (1 minute 15 seconds)

#### 2:15-2:30 - App Navigation (15 seconds)
**Screen**: Flutter app on emulator

**What to show**:
- Home screen
- Navigate to prediction screen

**Script**:
> "This is the Flutter mobile app. It has a clean interface with a home screen and prediction screen. Let me navigate to make a prediction."

#### 2:30-3:00 - Making Predictions (30 seconds)
**Screen**: Prediction screen - filling inputs

**What to show**:
- Enter values for all 6 fields:
  - Reviews: 50000
  - Size: 25.5 MB
  - Installs: 1000000
  - Price: 0.0
  - Type: Free
  - Category: GAME
- Click "Predict Rating"
- Show result

**Script**:
> "The app has 6 input fields matching our model features. Let me predict for a popular free game with 50,000 reviews, 25 MB size, and 1 million installs. The model predicts a rating of [X.XX] stars with high confidence."

#### 3:00-3:15 - Code Walkthrough (15 seconds)
**Screen**: VS Code showing main.dart API call

**What to show**:
- Line ~95: API URL
- Line ~145: HTTP POST request code

**Script**:
> "Here's the API integration code. The app sends an HTTP POST request to my deployed FastAPI endpoint with JSON payload and handles the response."

#### 3:15-3:30 - Validation Test (15 seconds)
**Screen**: Flutter app - invalid input

**What to show**:
- Enter invalid value (e.g., reviews = 500000000)
- Show error message

**Script**:
> "The app validates inputs. Let me try an invalid value... See, it shows an error message because reviews exceed the maximum allowed."

---

### ⏱️ 3:30-4:45 - Swagger UI Testing (1 minute 15 seconds)

#### 3:30-3:50 - Valid Prediction (20 seconds)
**Screen**: Swagger UI /docs page

**What to show**:
- Navigate to POST /predict
- Click "Try it out"
- Show example JSON
- Execute
- Show 200 response with prediction

**Script**:
> "Now testing the API via Swagger UI. Here's the predict endpoint with Pydantic model showing all required fields and their types. Let me test with valid data... Success! Returns predicted rating with model name and confidence."

#### 3:50-4:10 - Data Type Validation (20 seconds)
**Screen**: Swagger UI - type error test

**What to show**:
- Modify input: reviews = "fifty thousand" (string)
- Execute
- Show 422 error response

**Script**:
> "Testing type validation. If I send a string instead of integer for reviews... The API returns error 422 with detailed validation message. Pydantic is enforcing data types."

#### 4:10-4:30 - Range Validation (20 seconds)
**Screen**: Swagger UI - range error test

**What to show**:
- Modify input: reviews = 200000000 (exceeds max)
- Execute
- Show 422 error with range constraint message

**Script**:
> "Testing range constraints. Sending reviews value exceeding 100 million... Error 422 indicating the value is out of acceptable range. All constraints are working."

#### 4:30-4:45 - Additional Endpoints (15 seconds)
**Screen**: Swagger UI - other endpoints

**What to show**:
- GET /health endpoint
- GET /model-info endpoint
- Execute one to show response

**Script**:
> "The API includes health check and model-info endpoints. Health check shows the model is loaded and ready. Model-info returns performance metrics: RMSE, R-squared, and MAE."

---

### ⏱️ 4:45-5:00 - Conclusion (15 seconds)
**Camera**: ON
**Screen**: Your face or project summary

**Script**:
> "Summary: I built a complete ML pipeline with proper regression analysis, deployed a validated REST API, and created a mobile app. The models show good performance with RMSE of [X.XX], and all components integrate seamlessly. Thank you!"

---

## 📝 Recording Tips

### Technical Setup
1. **Screen Resolution**: 1920x1080 or 1280x720
2. **Frame Rate**: 30 FPS minimum
3. **Audio**: Clear microphone, no background noise
4. **Lighting**: Good lighting for camera
5. **Recording Software**: OBS Studio, Camtasia, or built-in screen recorder

### Best Practices
- ✅ Speak clearly and at moderate pace
- ✅ Keep camera on throughout (requirement!)
- ✅ Practice once before final recording
- ✅ Use mouse cursor to highlight important elements
- ✅ Zoom in on small text if needed
- ✅ Have all applications open and ready
- ✅ Close unnecessary notifications
- ✅ Test audio before recording

### Common Mistakes to Avoid
- ❌ Going over 5 minutes
- ❌ Camera off during presentation
- ❌ Spending too much time on one section
- ❌ Reading code line by line
- ❌ Not showing actual functionality
- ❌ Poor audio quality
- ❌ Messy desktop/background applications

---

## 🎯 What Graders Look For

### Notebook (Must Show)
- ✅ Dataset is not house prices
- ✅ Gradient descent implementation visible
- ✅ Loss curves displayed
- ✅ Multiple models trained
- ✅ Clear model comparison
- ✅ Scatter plots with regression line

### API (Must Show)
- ✅ Swagger UI accessible
- ✅ POST /predict works
- ✅ CORS configured (mention it)
- ✅ Pydantic validation active
- ✅ Type checking works
- ✅ Range checking works

### Mobile App (Must Show)
- ✅ App actually running (not just code)
- ✅ All 6 input fields visible
- ✅ Predict button works
- ✅ Result displays correctly
- ✅ API integration code shown
- ✅ Error handling demonstrated

### Explanation (Must Include)
- ✅ Why you chose this dataset
- ✅ How dataset impacts performance
- ✅ Why best model was selected
- ✅ Loss curve interpretation
- ✅ Model performance comparison

---

## 🚀 Upload Instructions

### Upload to YouTube
1. Go to youtube.com/upload
2. Select your video file
3. **Title**: "Mobile App Rating Prediction - ML Project"
4. **Description**:
   ```
   Machine Learning project demonstrating:
   - Linear Regression with Gradient Descent
   - Random Forest and Decision Tree models
   - FastAPI deployment with Pydantic validation
   - Flutter mobile app integration
   
   GitHub: https://github.com/Sougnabe/linear_regression_model
   ```
5. **Visibility**: Public or Unlisted
6. **Tags**: machine learning, linear regression, fastapi, flutter
7. Click "Publish"
8. Copy video URL

### Add to README
1. Open `README.md`
2. Find "Video Demo" section
3. Replace placeholder with: `[https://youtu.be/YOUR_VIDEO_ID](https://youtu.be/YOUR_VIDEO_ID)`
4. Commit and push to GitHub

---

## ✅ Pre-Upload Checklist

Before uploading to YouTube:
- [ ] Video is under 5 minutes
- [ ] Camera is visible throughout
- [ ] Audio is clear
- [ ] All three components demonstrated
- [ ] Explanations are clear and concise
- [ ] No sensitive information visible
- [ ] Video quality is good (720p minimum)

After uploading:
- [ ] Video link added to README.md
- [ ] Video is accessible (test in incognito mode)
- [ ] Timestamp works correctly

---

**Good luck with your recording! You've got this! 🎥🚀**

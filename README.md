# Mobile App Rating Prediction - Linear Regression Project

## Mission
Our mission is to empower mobile app developers with data-driven insights by predicting user ratings based on app characteristics. This machine learning solution helps developers optimize their apps for better user satisfaction and market success, ultimately bridging the gap between app features and user expectations.

## Dataset
**Source**: [Google Play Store Apps Dataset](https://www.kaggle.com/datasets/lava18/google-play-store-apps)

The dataset contains 10,000+ mobile applications from Google Play Store with features including:
- App reviews count
- App size (MB)
- Number of installs
- Price (USD)
- Category
- Rating (Target variable: 1.0 to 5.0 stars)

**Note**: If the dataset file is not available, the notebook will generate sample data for demonstration purposes.

## Project Structure

```
linear_regression_model/
│
├── summative/
│   ├── linear_regression/
│   │   └── Untitled1.ipynb          # Main Jupyter notebook with ML models
│   │
│   ├── API/
│   │   ├── prediction.py            # FastAPI application
│   │   ├── requirements.txt         # Python dependencies
│   │   └── saved_model/             # Trained model files (generated after running notebook)
│   │
│   └── FlutterApp/
│       ├── lib/
│       │   └── main.dart            # Flutter app main code
│       ├── pubspec.yaml             # Flutter dependencies
│       └── README.md                # Flutter setup instructions
│
└── README.md                        # This file
```

## Features Implemented

### ✅ Task 1: Linear Regression Models
- **Dataset**: Google Play Store Apps (regression task, not classification)
- **Data Preprocessing**: Cleaning, feature engineering, standardization
- **Visualizations**: 
  - Distribution plots of ratings
  - Correlation heatmap
  - Scatter plots (Reviews vs Rating, Size vs Rating, etc.)
  - Actual vs Predicted scatter plots for all models
- **Models Implemented**:
  1. **Linear Regression with Gradient Descent** (SGDRegressor)
     - 200 epochs training loop
     - Learning rate: 0.01
     - Loss curves plotted (train/test MSE over epochs)
  2. **Linear Regression** (closed-form solution)
  3. **Decision Tree Regressor**
  4. **Random Forest Regressor**
- **Model Evaluation**: MSE, RMSE, MAE, R² score for all models
- **Best Model Selection**: Automatically saves the model with lowest RMSE
- **Prediction Function**: Ready-to-use function for API integration

### ✅ Task 2: FastAPI with CORS and Pydantic
- **Endpoint**: `POST /predict` for predictions
- **CORS Middleware**: Configured for cross-origin requests
- **Pydantic Validation**:
  - Data type enforcement (int, float, str)
  - Range constraints:
    - `reviews`: 0 to 100,000,000
    - `size_mb`: 0.1 to 500.0
    - `installs`: 0 to 10,000,000,000
    - `price`: 0.0 to 400.0
    - `is_free`: 0 or 1
    - `category`: non-empty string
- **Additional Endpoints**:
  - `GET /`: API information
  - `GET /health`: Health check
  - `GET /model-info`: Model metadata
  - `GET /docs`: Swagger UI documentation

### ✅ Task 3: Flutter Mobile App
- **Multi-page app** with:
  - Home screen with navigation
  - Prediction screen with input form
- **Input Fields**: 6 text fields matching model features
- **Validation**: Client-side validation for all inputs
- **API Integration**: HTTP POST request to prediction endpoint
- **UI Features**:
  - Loading indicator during prediction
  - Success display with predicted rating
  - Error handling with user-friendly messages
  - Material Design with proper spacing and organization

## API Deployment URL

**Live API**: `https://linear-regression-model-gux3.onrender.com`  
**Swagger UI Documentation**: `https://linear-regression-model-gux3.onrender.com/docs`  
**Health Check**: `https://linear-regression-model-gux3.onrender.com/health`

> **Status**: ✅ Deployed and operational on Render

For local testing:
```bash
cd summative/API
pip install -r requirements.txt
python prediction.py
```
Then access: `http://localhost:8000/docs`

## Setup and Installation

### 1. Clone Repository
```bash
git clone https://github.com/Sougnabe/linear_regression_model.git
cd linear_regression_model/summative
```

### 2. Run Jupyter Notebook
```bash
cd linear_regression
jupyter notebook Untitled1.ipynb
```

**Steps**:
1. Download the dataset from Kaggle and place `googleplaystore.csv` in the notebook directory
2. Run all cells sequentially
3. Models will be saved to `../../API/saved_model/`

### 3. Run API Locally

```bash
cd ../API
pip install -r requirements.txt
python prediction.py
```

API will be available at:
- Main endpoint: `http://localhost:8000`
- Swagger docs: `http://localhost:8000/docs`

### 4. Run Flutter App

```bash
cd ../FlutterApp
flutter pub get
```

Update the API URL in `lib/main.dart`:
- For Android emulator: `http://10.0.2.2:8000/predict`
- For iOS simulator: `http://localhost:8000/predict`
- For deployed API: `https://your-api-url.com/predict`

Run the app:
```bash
flutter run
```

## Deployment Instructions

### Deploy API on Render

1. **Create account** at [render.com](https://render.com)

2. **Create new Web Service**:
   - Connect your GitHub repository
   - Root directory: `summative/API`
   - Build command: `pip install -r requirements.txt`
   - Start command: `uvicorn prediction:app --host 0.0.0.0 --port $PORT`

3. **Environment variables**:
   - Python version: 3.10 or higher

4. **Deploy** and copy the URL

5. **Test Swagger UI**: `https://your-app.onrender.com/docs`

### Alternative: Deploy on Railway

1. Visit [railway.app](https://railway.app)
2. Create new project from GitHub repo
3. Set root directory to `summative/API`
4. Railway auto-detects Python and deploys
5. Copy the deployed URL

### Update Flutter App with Deployed URL

In `FlutterApp/lib/main.dart`, line ~95:
```dart
final String apiUrl = 'https://your-deployed-api.com/predict';
```

## Video Demo

**Loom Video**: https://www.loom.com/share/2096bc70480b4dd3888bc564a40df667

The 5-minute video demonstrates:
1. ✅ Notebook walkthrough showing model training and results
2. ✅ Model performance comparison (loss curves, RMSE, R²)
3. ✅ Dataset impact discussion
4. ✅ Model selection justification
5. ✅ Mobile app making predictions (with camera on)
6. ✅ Swagger UI testing with various inputs
7. ✅ Data type and range validation testing

## Testing the API

### Using Swagger UI

1. Navigate to `https://your-api-url.com/docs`
2. Click on `POST /predict`
3. Click "Try it out"
4. Enter test data:
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
5. Click "Execute"
6. View predicted rating in response

### Test Cases

**Test 1 - Popular Free Game**:
```json
{
  "reviews": 100000,
  "size_mb": 50.0,
  "installs": 10000000,
  "price": 0.0,
  "is_free": 1,
  "category": "GAME"
}
```

**Test 2 - Paid Productivity App**:
```json
{
  "reviews": 5000,
  "size_mb": 15.0,
  "installs": 50000,
  "price": 4.99,
  "is_free": 0,
  "category": "PRODUCTIVITY"
}
```

**Test 3 - Range Validation Error**:
```json
{
  "reviews": 200000000,
  "size_mb": 25.0,
  "installs": 1000,
  "price": 0.0,
  "is_free": 1,
  "category": "SOCIAL"
}
```
Expected: Error due to reviews exceeding maximum (100,000,000)

## Model Performance Summary

| Model | Test RMSE | Test R² | Test MAE |
|-------|-----------|---------|----------|
| SGD Linear Regression | 0.XXXX | 0.XXXX | 0.XXXX |
| Linear Regression | 0.XXXX | 0.XXXX | 0.XXXX |
| Decision Tree | 0.XXXX | 0.XXXX | 0.XXXX |
| Random Forest | 0.XXXX | 0.XXXX | 0.XXXX |

> Values will be populated after running the notebook

**Best Model**: Automatically selected based on lowest RMSE

## Technologies Used

- **Machine Learning**: scikit-learn, pandas, numpy
- **Visualization**: matplotlib, seaborn
- **API**: FastAPI, Pydantic, Uvicorn
- **Mobile**: Flutter, Dart
- **Deployment**: Render / Railway / Heroku

## Contributors

- **Student**: Richard Sougnabe
- **Repository**: https://github.com/Sougnabe/linear_regression_model
- **Course**: Mobile App Regression Analysis

## License

This project is submitted as part of an academic assignment.

---

## Quick Start Commands

```bash
# 1. Train model
cd summative/linear_regression
jupyter notebook Untitled1.ipynb  # Run all cells

# 2. Start API locally
cd ../API
pip install -r requirements.txt
python prediction.py

# 3. Run Flutter app
cd ../FlutterApp
flutter pub get
flutter run

# 4. Test API
# Visit http://localhost:8000/docs
```

## Support

For issues or questions:
1. Check the README files in each subdirectory
2. Verify all dependencies are installed
3. Ensure the model files are generated (run notebook first)
4. Check API URL configuration in Flutter app

---

**Status**: ✅ All requirements implemented and ready for submission

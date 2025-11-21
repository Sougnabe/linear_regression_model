# App Rating Prediction API 📱⭐

FastAPI REST API for predicting Google Play Store app ratings using Machine Learning.

## 🚀 Deployed API

**Public URL**: `https://app-rating-prediction-api.onrender.com`

## 📋 Endpoints

### 1. Health Check
```bash
GET /health
```
Returns API health status and model information.

### 2. Model Information
```bash
GET /model-info
```
Returns detailed model metadata and performance metrics.

### 3. Predict Rating
```bash
POST /predict
Content-Type: application/json

{
  "reviews": 100000,
  "size_mb": 45.0,
  "installs": 10000000,
  "price": 0.0,
  "is_free": 1,
  "category": "GAME"
}
```

**Response:**
```json
{
  "predicted_rating": 4.17,
  "model_name": "Random Forest",
  "confidence": "high"
}
```

### 4. Interactive Documentation
```bash
GET /docs
```
Swagger UI with interactive API testing.

## 🎯 Input Features

| Feature | Type | Range | Description |
|---------|------|-------|-------------|
| `reviews` | int | 0 - 100M | Number of user reviews |
| `size_mb` | float | 0.1 - 500 | App size in megabytes |
| `installs` | int | 0 - 10B | Number of installations |
| `price` | float | 0 - 400 | Price in USD (0 for free) |
| `is_free` | int | 0 or 1 | 1=Free, 0=Paid |
| `category` | string | - | App category (GAME, SOCIAL, etc.) |

## 🤖 Model

- **Algorithm**: Random Forest Regressor (100 trees)
- **Training Data**: 9,366 Google Play Store apps
- **Performance**: 
  - RMSE: 0.4653
  - MAE: 0.3180
  - R²: 0.1216

## 🛠️ Local Development

### Installation
```bash
pip install -r requirements.txt
```

### Run API
```bash
python prediction.py
```

API will be available at `http://localhost:8000`

### Test API
```bash
python test_api.py
```

## 📦 Files Structure

```
API/
├── prediction.py          # Main FastAPI application
├── test_api.py           # API testing script
├── requirements.txt      # Python dependencies
├── render.yaml          # Render deployment config
├── saved_model/         # Trained ML models
│   ├── best_model.pkl
│   ├── preprocessor.pkl
│   ├── metadata.pkl
│   └── ...
└── README.md
```

## 🌐 Deployment on Render

1. Push code to GitHub
2. Connect repository to Render
3. Deploy as Web Service
4. Free tier with automatic HTTPS

## 📱 Flutter App Integration

Update API URL in `main.dart`:
```dart
final apiUrl = 'https://app-rating-prediction-api.onrender.com/predict';
```

## 🔗 Related Files

- **Jupyter Notebook**: `../linear_regression/Untitled1.ipynb`
- **Flutter App**: `../flutter_app/`
- **Dataset**: `../linear_regression/googleplaystore.csv`

## 📄 License

Educational project - Google Play Store Apps Dataset

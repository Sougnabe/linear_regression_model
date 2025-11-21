# API Deployment Guide

This guide explains how to deploy the FastAPI application to various platforms.

## Prerequisites

- GitHub account
- API code in the repository
- Model files generated from Jupyter notebook

## Option 1: Deploy on Render (Recommended)

### Step 1: Prepare Repository

Ensure your GitHub repository has:
- `summative/API/prediction.py`
- `summative/API/requirements.txt`
- `summative/API/saved_model/` (with model files)

### Step 2: Create Render Account

1. Go to [https://render.com](https://render.com)
2. Sign up with GitHub account
3. Authorize Render to access your repositories

### Step 3: Create New Web Service

1. Click **"New +"** → **"Web Service"**
2. Connect your GitHub repository: `Sougnabe/linear_regression_model`
3. Configure the service:
   - **Name**: `app-rating-predictor-api`
   - **Region**: Select closest to you
   - **Branch**: `main`
   - **Root Directory**: `summative/API`
   - **Runtime**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn prediction:app --host 0.0.0.0 --port $PORT`

### Step 4: Environment Variables (Optional)

If needed, add environment variables:
- `PYTHON_VERSION`: `3.10.0` or higher

### Step 5: Deploy

1. Click **"Create Web Service"**
2. Wait for deployment (5-10 minutes)
3. Render will:
   - Clone your repository
   - Install dependencies
   - Start the application

### Step 6: Get API URL

Once deployed, you'll get a URL like:
```
https://app-rating-predictor-api.onrender.com
```

### Step 7: Test Swagger UI

1. Visit: `https://your-app.onrender.com/docs`
2. Test the `/predict` endpoint
3. Verify all endpoints work correctly

---

## Option 2: Deploy on Railway

### Step 1: Create Railway Account

1. Go to [https://railway.app](https://railway.app)
2. Sign up with GitHub

### Step 2: Create New Project

1. Click **"New Project"**
2. Select **"Deploy from GitHub repo"**
3. Choose `Sougnabe/linear_regression_model`

### Step 3: Configure

1. Railway auto-detects Python
2. Set root directory: `summative/API`
3. Railway automatically:
   - Installs dependencies from `requirements.txt`
   - Detects and runs the FastAPI app

### Step 4: Get URL

Railway provides a public URL automatically:
```
https://app-rating-predictor-production.up.railway.app
```

---

## Option 3: Deploy on Heroku

### Step 1: Install Heroku CLI

```bash
# Download from https://devcenter.heroku.com/articles/heroku-cli
heroku --version
```

### Step 2: Login to Heroku

```bash
heroku login
```

### Step 3: Create Procfile

In `summative/API/`, create a file named `Procfile`:
```
web: uvicorn prediction:app --host 0.0.0.0 --port $PORT
```

### Step 4: Create runtime.txt

In `summative/API/`, create `runtime.txt`:
```
python-3.10.12
```

### Step 5: Deploy

```bash
cd summative/API
heroku create app-rating-predictor
git subtree push --prefix summative/API heroku main
```

### Step 6: Open App

```bash
heroku open
# Visit /docs for Swagger UI
```

---

## Verifying Deployment

### 1. Check Root Endpoint

```bash
curl https://your-api-url.com/
```

Expected response:
```json
{
  "message": "Mobile App Rating Prediction API",
  "version": "1.0.0",
  "status": "active"
}
```

### 2. Check Health Endpoint

```bash
curl https://your-api-url.com/health
```

Expected response:
```json
{
  "status": "healthy",
  "model_loaded": true,
  "model_name": "Random Forest Regressor"
}
```

### 3. Test Prediction

```bash
curl -X POST https://your-api-url.com/predict \
  -H "Content-Type: application/json" \
  -d '{
    "reviews": 50000,
    "size_mb": 25.5,
    "installs": 1000000,
    "price": 0.0,
    "is_free": 1,
    "category": "GAME"
  }'
```

Expected response:
```json
{
  "predicted_rating": 4.25,
  "model_name": "Random Forest Regressor",
  "confidence": "high"
}
```

---

## Swagger UI Testing

### Access Swagger UI

Navigate to: `https://your-api-url.com/docs`

### Test Cases for Demo Video

#### Test 1: Valid Input - Free Game
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

#### Test 2: Valid Input - Paid App
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

#### Test 3: Invalid Range - Too Many Reviews
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
Expected: **Error 422** - Validation error

#### Test 4: Invalid Type - String for Number
```json
{
  "reviews": "fifty thousand",
  "size_mb": 25.0,
  "installs": 1000000,
  "price": 0.0,
  "is_free": 1,
  "category": "GAME"
}
```
Expected: **Error 422** - Type validation error

#### Test 5: Missing Field
```json
{
  "reviews": 50000,
  "size_mb": 25.0,
  "installs": 1000000,
  "price": 0.0,
  "is_free": 1
}
```
Expected: **Error 422** - Missing required field 'category'

---

## Update Flutter App

After deployment, update the API URL in Flutter app:

**File**: `FlutterApp/lib/main.dart`

**Line ~95**:
```dart
// Replace this
final String apiUrl = 'https://your-api-url.com/predict';

// With your actual deployed URL
final String apiUrl = 'https://app-rating-predictor.onrender.com/predict';
```

---

## Monitoring and Logs

### Render Logs
1. Go to your service dashboard
2. Click on **"Logs"** tab
3. Monitor real-time API requests

### Railway Logs
1. Select your project
2. Click on **"Deployments"**
3. View logs for debugging

### Heroku Logs
```bash
heroku logs --tail -a app-rating-predictor
```

---

## Troubleshooting

### Model Not Found Error

**Problem**: API returns "Model not loaded"

**Solution**:
1. Ensure `saved_model/` directory exists in repository
2. Run Jupyter notebook to generate model files
3. Commit and push model files to GitHub
4. Redeploy the application

### Port Binding Error

**Problem**: Application fails to start

**Solution**: Ensure start command uses `$PORT`:
```bash
uvicorn prediction:app --host 0.0.0.0 --port $PORT
```

### Dependencies Installation Error

**Problem**: Deployment fails during pip install

**Solution**:
1. Test locally: `pip install -r requirements.txt`
2. Ensure all package versions are compatible
3. Update `requirements.txt` with specific versions

### CORS Error in Flutter App

**Problem**: API request blocked by CORS

**Solution**: Verify CORS middleware in `prediction.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

---

## Performance Optimization

### 1. Enable Caching

Add Redis for caching predictions (optional):
```python
# In prediction.py
from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend
```

### 2. Use Gunicorn for Production

Update start command:
```bash
gunicorn prediction:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:$PORT
```

Add to `requirements.txt`:
```
gunicorn==21.2.0
```

---

## Cost Considerations

### Render
- **Free Tier**: 750 hours/month
- **Starter**: $7/month (always-on)

### Railway
- **Free Tier**: $5 credit/month
- **Paid**: Pay-as-you-go after credit

### Heroku
- **Free Tier**: Discontinued
- **Basic**: $7/month minimum

---

## Security Best Practices

1. **Use HTTPS** (automatic on Render/Railway/Heroku)
2. **Set Rate Limiting** (add middleware)
3. **Restrict CORS origins** in production
4. **Add API Key authentication** for sensitive data
5. **Monitor usage** and set alerts

---

## Next Steps After Deployment

1. ✅ Copy deployed URL
2. ✅ Update `README.md` with actual URL
3. ✅ Test all endpoints via Swagger UI
4. ✅ Update Flutter app with deployed URL
5. ✅ Test Flutter app with deployed API
6. ✅ Record demo video
7. ✅ Submit GitHub repository link

---

**Deployment Status**: Ready for production! 🚀

"""
Mobile App Rating Prediction API
FastAPI application for predicting mobile app ratings based on app characteristics.
"""

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, confloat, conint, validator
import joblib
import pandas as pd
import numpy as np
from typing import Optional
import os

# Initialize FastAPI app
app = FastAPI(
    title="Mobile App Rating Prediction API",
    description="Predict mobile app ratings based on app characteristics using machine learning",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load model and metadata at startup
MODEL_DIR = os.path.join(os.path.dirname(__file__), "saved_model")

try:
    metadata = joblib.load(os.path.join(MODEL_DIR, "metadata.pkl"))
    model_type = metadata['model_type']
    
    if model_type == 'sgd':
        model = joblib.load(os.path.join(MODEL_DIR, "best_model.pkl"))
        preprocessor = joblib.load(os.path.join(MODEL_DIR, "preprocessor.pkl"))
    else:
        # For non-SGD models, preprocessor is included in the model file
        model = joblib.load(os.path.join(MODEL_DIR, "best_model.pkl"))
        preprocessor = None
    
    print(f"✓ Model loaded successfully: {metadata['model_name']}")
    print(f"✓ Test RMSE: {metadata['test_rmse']:.4f}")
    print(f"✓ Test R²: {metadata['test_r2']:.4f}")
    
except Exception as e:
    print(f"ERROR: Failed to load model: {str(e)}")
    print("Make sure the model files are in the 'saved_model' directory")
    model = None
    preprocessor = None
    metadata = None


# Pydantic model for input validation
class AppFeatures(BaseModel):
    """
    Input features for app rating prediction.
    All fields have data type and range constraints.
    """
    
    reviews: conint(ge=0, le=100000000) = Field(
        ...,
        description="Number of user reviews (0 to 100,000,000)",
        example=50000
    )
    
    size_mb: confloat(ge=0.1, le=500.0) = Field(
        ...,
        description="App size in megabytes (0.1 to 500 MB)",
        example=25.5
    )
    
    installs: conint(ge=0, le=10000000000) = Field(
        ...,
        description="Number of app installs (0 to 10,000,000,000)",
        example=1000000
    )
    
    price: confloat(ge=0.0, le=400.0) = Field(
        ...,
        description="App price in USD (0.0 to 400.0)",
        example=0.0
    )
    
    is_free: conint(ge=0, le=1) = Field(
        ...,
        description="1 if app is free, 0 if paid",
        example=1
    )
    
    category: str = Field(
        ...,
        description="App category (e.g., GAME, SOCIAL, PRODUCTIVITY, ENTERTAINMENT, TOOLS)",
        example="GAME"
    )
    
    @validator('category')
    def validate_category(cls, v):
        """Validate that category is not empty"""
        if not v or len(v.strip()) == 0:
            raise ValueError("Category cannot be empty")
        return v.strip().upper()
    
    @validator('is_free')
    def validate_is_free(cls, v):
        """Ensure is_free is binary"""
        if v not in [0, 1]:
            raise ValueError("is_free must be 0 or 1")
        return v
    
    class Config:
        schema_extra = {
            "example": {
                "reviews": 50000,
                "size_mb": 25.5,
                "installs": 1000000,
                "price": 0.0,
                "is_free": 1,
                "category": "GAME"
            }
        }


class PredictionResponse(BaseModel):
    """Response model for predictions"""
    predicted_rating: float = Field(..., description="Predicted app rating (1.0 to 5.0)")
    model_name: str = Field(..., description="Name of the model used")
    confidence: Optional[str] = Field(None, description="Confidence level")
    
    class Config:
        schema_extra = {
            "example": {
                "predicted_rating": 4.25,
                "model_name": "Random Forest Regressor",
                "confidence": "high"
            }
        }


@app.get("/")
async def root():
    """Root endpoint with API information"""
    return {
        "message": "Mobile App Rating Prediction API",
        "version": "1.0.0",
        "status": "active",
        "endpoints": {
            "docs": "/docs",
            "predict": "/predict (POST)",
            "health": "/health"
        }
    }


@app.get("/health")
async def health_check():
    """Health check endpoint"""
    if model is None:
        return {
            "status": "unhealthy",
            "message": "Model not loaded"
        }
    
    return {
        "status": "healthy",
        "model_loaded": True,
        "model_name": metadata['model_name'] if metadata else "Unknown",
        "model_type": metadata['model_type'] if metadata else "Unknown"
    }


@app.post("/predict", response_model=PredictionResponse)
async def predict_rating(features: AppFeatures):
    """
    Predict app rating based on provided features.
    
    Parameters:
    - reviews: Number of user reviews
    - size_mb: App size in MB
    - installs: Number of installs
    - price: App price in USD
    - is_free: 1 if free, 0 if paid
    - category: App category
    
    Returns:
    - predicted_rating: Predicted rating (1.0 to 5.0)
    - model_name: Name of the model used
    """
    
    if model is None:
        raise HTTPException(
            status_code=503,
            detail="Model not loaded. Please check server logs."
        )
    
    try:
        # Create input dataframe
        input_data = pd.DataFrame({
            'Reviews': [features.reviews],
            'Size_MB': [features.size_mb],
            'Installs_Num': [features.installs],
            'Price_USD': [features.price],
            'Is_Free': [features.is_free],
            'Category': [features.category]
        })
        
        # Make prediction
        # Load preprocessor for all model types
        if preprocessor is None:
            # Load preprocessor if not already loaded
            preprocessor_obj = joblib.load(os.path.join(MODEL_DIR, "preprocessor.pkl"))
            input_processed = preprocessor_obj.transform(input_data)
        else:
            input_processed = preprocessor.transform(input_data)
        
        prediction = model.predict(input_processed)[0]
        
        # Clip prediction to valid range (1.0 to 5.0)
        prediction = float(np.clip(prediction, 1.0, 5.0))
        
        # Determine confidence based on prediction range
        if 3.5 <= prediction <= 4.5:
            confidence = "high"
        elif 3.0 <= prediction < 3.5 or 4.5 < prediction <= 5.0:
            confidence = "medium"
        else:
            confidence = "low"
        
        return PredictionResponse(
            predicted_rating=round(prediction, 2),
            model_name=metadata['model_name'],
            confidence=confidence
        )
        
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Prediction error: {str(e)}"
        )


@app.get("/model-info")
async def model_info():
    """Get information about the loaded model"""
    if metadata is None:
        raise HTTPException(
            status_code=503,
            detail="Model metadata not available"
        )
    
    return {
        "model_name": metadata['model_name'],
        "model_type": metadata['model_type'],
        "features": metadata['features'],
        "performance": {
            "test_rmse": round(metadata['test_rmse'], 4),
            "test_r2": round(metadata['test_r2'], 4),
            "test_mae": round(metadata['test_mae'], 4)
        }
    }


if __name__ == "__main__":
    import uvicorn
    import os
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)

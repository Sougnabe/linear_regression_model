"""
Script to download the Google Play Store Apps dataset
Run this script to automatically download the dataset for the project
"""

import os
import urllib.request
import zipfile

def download_dataset():
    """Download dataset from Kaggle (requires Kaggle API)"""
    
    print("="*70)
    print("DATASET DOWNLOAD INSTRUCTIONS")
    print("="*70)
    print("\nOption 1: Manual Download (Recommended)")
    print("-" * 70)
    print("1. Visit: https://www.kaggle.com/datasets/lava18/google-play-store-apps")
    print("2. Click 'Download' button (requires Kaggle account)")
    print("3. Extract 'googleplaystore.csv' to:")
    print(f"   {os.path.join(os.getcwd(), 'googleplaystore.csv')}")
    
    print("\n\nOption 2: Using Kaggle API")
    print("-" * 70)
    print("1. Install Kaggle API:")
    print("   pip install kaggle")
    print("\n2. Set up Kaggle credentials:")
    print("   - Go to https://www.kaggle.com/account")
    print("   - Click 'Create New API Token'")
    print("   - Place kaggle.json in:")
    print("     Windows: C:\\Users\\<username>\\.kaggle\\kaggle.json")
    print("     Linux/Mac: ~/.kaggle/kaggle.json")
    print("\n3. Run:")
    print("   kaggle datasets download -d lava18/google-play-store-apps")
    print("   unzip google-play-store-apps.zip")
    
    print("\n\nOption 3: Use Sample Data")
    print("-" * 70)
    print("The notebook will automatically generate sample data if the")
    print("dataset file is not found. This is for demonstration only.")
    
    print("\n" + "="*70)
    print("\nAfter downloading, run the Jupyter notebook:")
    print("jupyter notebook Untitled1.ipynb")
    print("="*70)

if __name__ == "__main__":
    download_dataset()

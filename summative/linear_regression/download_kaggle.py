"""
Quick script to download Google Play Store dataset using Kaggle API
"""
import os

try:
    # Import kaggle
    import kaggle
    
    print("=" * 70)
    print("📥 DOWNLOADING GOOGLE PLAY STORE DATASET")
    print("=" * 70)
    
    # Download dataset
    print("\n⏳ Downloading from Kaggle...")
    kaggle.api.dataset_download_files(
        'lava18/google-play-store-apps',
        path='.',
        unzip=True
    )
    
    print("\n✅ Download complete!")
    
    # Verify file exists
    if os.path.exists('googleplaystore.csv'):
        file_size = os.path.getsize('googleplaystore.csv') / (1024 * 1024)
        print(f"✅ File found: googleplaystore.csv ({file_size:.2f} MB)")
        
        # Quick check
        import pandas as pd
        df = pd.read_csv('googleplaystore.csv')
        print(f"✅ Rows: {len(df):,}")
        print(f"✅ Columns: {len(df.columns)}")
        print(f"\n📊 Preview:")
        print(df.head())
        print("\n🎉 Dataset is ready! You can now run the Jupyter notebook.")
    else:
        print("\n⚠️ File not found after download. Check for zip files.")
        
except ImportError:
    print("❌ Kaggle not installed. Run: pip install kaggle")
except Exception as e:
    print(f"\n❌ Error: {e}")
    print("\nPossible causes:")
    print("1. Kaggle credentials not configured")
    print("2. No internet connection")
    print("3. Dataset URL changed")
    print("\nSolution:")
    print("• Get API token from: https://www.kaggle.com/account")
    print("• Place kaggle.json in: %USERPROFILE%\\.kaggle\\")
    print("• Or download manually from: https://www.kaggle.com/datasets/lava18/google-play-store-apps")

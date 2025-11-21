"""
Download Google Play Store dataset using kagglehub
This is the simplest method - no API token needed!
"""
import kagglehub
import shutil
import os

print("=" * 70)
print("📥 DOWNLOADING GOOGLE PLAY STORE DATASET")
print("=" * 70)

try:
    # Download latest version
    print("\n⏳ Downloading dataset from Kaggle...")
    print("   This may take a minute...")
    
    path = kagglehub.dataset_download("lava18/google-play-store-apps")
    
    print(f"\n✅ Dataset downloaded to: {path}")
    
    # Find the CSV file
    csv_file = None
    for file in os.listdir(path):
        if file.endswith('.csv') and 'googleplaystore' in file.lower():
            csv_file = os.path.join(path, file)
            break
    
    if csv_file:
        # Copy to current directory
        destination = 'googleplaystore.csv'
        shutil.copy2(csv_file, destination)
        
        print(f"✅ File copied to: {os.path.abspath(destination)}")
        
        # Verify
        file_size = os.path.getsize(destination) / (1024 * 1024)
        print(f"✅ File size: {file_size:.2f} MB")
        
        # Quick preview
        import pandas as pd
        df = pd.read_csv(destination)
        print(f"\n📊 Dataset Preview:")
        print(f"   Rows: {len(df):,}")
        print(f"   Columns: {len(df.columns)}")
        print(f"   Columns: {', '.join(df.columns[:6])}...")
        print(f"\n   First few apps:")
        print(df[['App', 'Category', 'Rating', 'Reviews']].head())
        
        print("\n" + "=" * 70)
        print("🎉 SUCCESS! Dataset is ready to use!")
        print("=" * 70)
        print("\nNext step: Open and run the Jupyter notebook")
        print("   jupyter notebook Untitled1.ipynb")
        print("=" * 70)
        
    else:
        print("\n⚠️ CSV file not found in downloaded path")
        print(f"   Check manually in: {path}")
        
except Exception as e:
    print(f"\n❌ Error: {e}")
    print("\nTroubleshooting:")
    print("1. Make sure you have internet connection")
    print("2. Try again - sometimes Kaggle servers are slow")
    print("3. If it keeps failing, use manual download:")
    print("   → https://www.kaggle.com/datasets/lava18/google-play-store-apps")

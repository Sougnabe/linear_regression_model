# 📊 Dataset Setup Instructions

## Required Dataset

**Name**: Google Play Store Apps  
**Source**: Kaggle  
**URL**: https://www.kaggle.com/datasets/lava18/google-play-store-apps  
**Size**: ~2.3 MB  
**Records**: 10,841 apps  

## Why This Dataset?

This dataset is perfect for the assignment because:
- ✅ **Regression task**: Predicting continuous ratings (1.0 to 5.0)
- ✅ **NOT house prices**: Completely different domain (mobile apps)
- ✅ **Rich features**: Multiple numeric and categorical variables
- ✅ **Real-world relevance**: Aligned with mobile app mission
- ✅ **Sufficient size**: Enough data for proper model training

## Download Options

### Option 1: Manual Download (Recommended)

1. **Create Kaggle Account**
   - Go to https://www.kaggle.com
   - Sign up (free account)
   - Verify email

2. **Download Dataset**
   - Visit: https://www.kaggle.com/datasets/lava18/google-play-store-apps
   - Click blue "Download" button (top right)
   - File will download as `archive.zip`

3. **Extract File**
   - Unzip `archive.zip`
   - Find `googleplaystore.csv`
   - Place it in: `summative/linear_regression/` folder

4. **Verify**
   ```bash
   cd summative/linear_regression
   ls googleplaystore.csv  # Should show the file
   ```

### Option 2: Using Kaggle API

1. **Install Kaggle API**
   ```bash
   pip install kaggle
   ```

2. **Get API Credentials**
   - Go to https://www.kaggle.com/account
   - Scroll to "API" section
   - Click "Create New API Token"
   - File `kaggle.json` will download

3. **Place Credentials**
   
   **Windows**:
   ```bash
   mkdir %USERPROFILE%\.kaggle
   move kaggle.json %USERPROFILE%\.kaggle\
   ```
   
   **Linux/Mac**:
   ```bash
   mkdir ~/.kaggle
   mv kaggle.json ~/.kaggle/
   chmod 600 ~/.kaggle/kaggle.json
   ```

4. **Download via Command**
   ```bash
   cd summative/linear_regression
   kaggle datasets download -d lava18/google-play-store-apps
   unzip google-play-store-apps.zip
   ```

### Option 3: Use Sample Data (Fallback)

If you cannot download the dataset, the notebook will automatically generate sample data:
- 500 sample apps
- Realistic feature distributions
- Sufficient for demonstrating functionality
- **Note**: Performance metrics will differ

## Dataset Features

After loading, you'll have these columns:

### Numeric Features (used in model)
- `Reviews`: Number of user reviews
- `Size`: App size (cleaned to MB)
- `Installs`: Number of installations (cleaned to numeric)
- `Price`: App price in USD (cleaned)
- `Rating`: **Target variable** (1.0 to 5.0)

### Categorical Features (used in model)
- `Category`: App category (GAME, SOCIAL, etc.)
- `Type`: Free or Paid

### Other Columns (informational)
- `App`: App name
- `Content Rating`: Age rating
- `Genres`: App genre
- `Last Updated`: Update date
- `Current Ver`: Version number
- `Android Ver`: Required Android version

## Data Statistics

**Expected Stats** (after cleaning):
- Total apps: ~9,000 (after removing missing ratings)
- Rating range: 1.0 - 5.0
- Average rating: ~4.2
- Categories: 33 unique
- Free apps: ~92%
- Paid apps: ~8%

## Troubleshooting

### Issue: "File not found"
**Solution**: 
- Verify file name is exactly `googleplaystore.csv`
- Check file location: `summative/linear_regression/googleplaystore.csv`
- Run: `python download_dataset.py` for instructions

### Issue: "Permission denied" (Kaggle API)
**Solution**:
```bash
# Linux/Mac
chmod 600 ~/.kaggle/kaggle.json

# Windows - should work by default
```

### Issue: "403 Forbidden" (Kaggle API)
**Solution**:
- Verify Kaggle account is verified (check email)
- Re-download API token
- Replace old `kaggle.json`

### Issue: Dataset too large for repository
**Solution**:
- Dataset is already in `.gitignore`
- Don't commit CSV to GitHub
- Users download separately
- This is standard practice

## Alternative Datasets (if needed)

If the primary dataset is unavailable, these are acceptable alternatives:

### 1. Apple App Store Apps
- **URL**: https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps
- **Target**: User ratings
- **Size**: 7,000+ apps

### 2. Steam Games Dataset
- **URL**: https://www.kaggle.com/datasets/nikdavis/steam-store-games
- **Target**: Rating or price
- **Size**: 27,000+ games

### 3. Movie Ratings Dataset
- **URL**: https://www.kaggle.com/datasets/tmdb/tmdb-movie-metadata
- **Target**: Vote average
- **Size**: 5,000+ movies

**Note**: If using alternative, update mission statement in README to match the domain.

## Verification

After downloading, verify the dataset:

```python
import pandas as pd

# Load dataset
df = pd.read_csv('googleplaystore.csv')

# Check shape
print(f"Shape: {df.shape}")  # Should be ~10841 rows

# Check columns
print(f"Columns: {df.columns.tolist()}")

# Check ratings
print(f"Ratings: {df['Rating'].describe()}")
```

Expected output:
```
Shape: (10841, 13)
Columns: ['App', 'Category', 'Rating', 'Reviews', 'Size', 'Installs', ...]
Ratings: 
count    9367.0
mean        4.19
std         0.54
min         1.00
max         5.00
```

## Ready to Start?

Once you have the dataset:

1. ✅ Dataset file in correct location
2. ✅ File size is ~2.3 MB
3. ✅ File has 10,000+ rows
4. ✅ Rating column exists

**Next step**: Open `Untitled1.ipynb` and run all cells!

```bash
cd summative/linear_regression
jupyter notebook Untitled1.ipynb
```

---

## Need Help?

- Kaggle Help: https://www.kaggle.com/contact
- Dataset Issues: Check Kaggle dataset discussion tab
- Project Issues: Check README.md and SUBMISSION_CHECKLIST.md

**Good luck! 🚀**

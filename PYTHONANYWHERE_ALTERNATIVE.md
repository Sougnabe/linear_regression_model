# 🌐 Alternative: Déploiement sur PythonAnywhere (100% Gratuit)

Si Render ne fonctionne pas, PythonAnywhere est une excellente alternative gratuite pour les débutants.

## Avantages PythonAnywhere
✅ Toujours actif (pas de sommeil)  
✅ 100% gratuit (pas de carte bancaire)  
✅ Interface simple  
✅ Support Python natif  

## ⚠️ Limitations
❌ FastAPI ne fonctionne pas directement (il faut adapter en Flask)  
❌ URL moins jolie: `username.pythonanywhere.com`  
❌ 512 MB d'espace disque  

## 📝 Instructions rapides

### 1. Créer un compte
- Allez sur [pythonanywhere.com](https://www.pythonanywhere.com)
- Créez un compte gratuit (Beginner)

### 2. Upload des fichiers
Dans l'onglet **Files**:
```
/home/username/
  ├── prediction.py
  ├── requirements.txt
  └── saved_model/
      ├── best_model.pkl
      ├── preprocessor.pkl
      └── metadata.pkl
```

### 3. Installer les dépendances
Dans l'onglet **Consoles** > Bash:
```bash
pip install --user fastapi uvicorn joblib pandas numpy scikit-learn
```

### 4. Créer une Web App
- Onglet **Web**
- "Add a new web app"
- Framework: **Flask**
- Python version: **3.10**

### 5. Configuration WSGI
Éditez `/var/www/username_pythonanywhere_com_wsgi.py`:
```python
import sys
path = '/home/username'
if path not in sys.path:
    sys.path.append(path)

from prediction import app as application
```

### 6. Reload et tester
- Cliquez sur **Reload**
- Testez: `https://username.pythonanywhere.com/health`

---

## 🚀 **RECOMMANDATION: Utilisez Render**

Render est plus simple pour FastAPI et offre une meilleure expérience. Suivez le guide `RENDER_DEPLOYMENT_GUIDE.md` pour un déploiement en 5 minutes!

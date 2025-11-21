# 🚀 Guide de Déploiement API sur Render

## Étape 1: Créer un compte Render

1. Allez sur [render.com](https://render.com)
2. Cliquez sur **"Get Started"**
3. Connectez-vous avec votre compte GitHub

## Étape 2: Créer un nouveau Web Service

1. Dans le dashboard Render, cliquez sur **"New +"**
2. Sélectionnez **"Web Service"**
3. Connectez votre repository GitHub: `Sougnabe/linear_regression_model`
4. Cliquez sur **"Connect"**

## Étape 3: Configuration du Service

### Paramètres de base:
- **Name**: `app-rating-prediction-api` (ou votre choix)
- **Region**: `Oregon (US West)` ou la plus proche
- **Branch**: `main`
- **Root Directory**: `summative/API`
- **Runtime**: `Python 3`

### Commandes de build et démarrage:
- **Build Command**: 
  ```bash
  pip install -r requirements.txt
  ```

- **Start Command**:
  ```bash
  uvicorn prediction:app --host 0.0.0.0 --port $PORT
  ```

### Plan:
- Sélectionnez **"Free"** (gratuit)
  - 512 MB RAM
  - Service s'endort après 15 min d'inactivité
  - Se réveille automatiquement à la première requête

### Variables d'environnement (optionnel):
Vous pouvez ajouter des variables si nécessaire, mais le code utilise déjà `PORT` automatiquement.

## Étape 4: Déploiement

1. Cliquez sur **"Create Web Service"**
2. Render va:
   - Cloner votre repository
   - Installer les dépendances (`requirements.txt`)
   - Démarrer l'API avec uvicorn
   - Générer une URL publique (HTTPS automatique)

⏳ **Le déploiement prend environ 2-5 minutes**

## Étape 5: Vérifier le déploiement

Une fois déployé, Render vous donne une URL comme:
```
https://app-rating-prediction-api.onrender.com
```

### Tester l'API:

1. **Health Check**:
   ```
   https://app-rating-prediction-api.onrender.com/health
   ```

2. **Documentation interactive**:
   ```
   https://app-rating-prediction-api.onrender.com/docs
   ```

3. **Test de prédiction** (avec curl ou Postman):
   ```bash
   curl -X POST "https://app-rating-prediction-api.onrender.com/predict" \
     -H "Content-Type: application/json" \
     -d '{
       "reviews": 100000,
       "size_mb": 45.0,
       "installs": 10000000,
       "price": 0.0,
       "is_free": 1,
       "category": "GAME"
     }'
   ```

## Étape 6: Mettre à jour l'app Flutter

Une fois l'API déployée, mettez à jour l'URL dans votre app Flutter:

**Fichier: `summative/FlutterApp/lib/main.dart`**
```dart
final String apiUrl = 'https://votre-url.onrender.com/predict';
```

## 📊 Monitoring

Dans le dashboard Render:
- **Logs**: Voir les logs en temps réel
- **Metrics**: CPU, RAM, requêtes
- **Events**: Historique des déploiements

## 🔄 Mises à jour automatiques

Render redéploie automatiquement à chaque push sur la branche `main`:
```bash
git add .
git commit -m "Update API"
git push
```

## ⚠️ Limitations du plan gratuit

- Service s'endort après 15 min d'inactivité
- Première requête après sommeil prend ~30 secondes (cold start)
- 750 heures/mois d'exécution gratuite
- Bande passante limitée

## 🎯 Alternative: Railway

Si Render ne fonctionne pas, essayez [Railway.app](https://railway.app):
1. Même configuration
2. 500h gratuites/mois
3. Déploiement similaire

## ✅ Vérification finale

Avant de soumettre le projet, testez:
- [ ] `/health` retourne `{"status":"healthy"}`
- [ ] `/model-info` retourne les métadonnées
- [ ] `/predict` retourne une prédiction valide
- [ ] `/docs` affiche Swagger UI
- [ ] L'app Flutter peut se connecter à l'API

## 🔗 URLs à noter

- **Repository GitHub**: https://github.com/Sougnabe/linear_regression_model
- **API déployée**: https://[votre-nom].onrender.com
- **Documentation**: https://[votre-nom].onrender.com/docs

## 🆘 Dépannage

### Erreur: "Build failed"
- Vérifiez `requirements.txt`
- Assurez-vous que `Root Directory` = `summative/API`

### Erreur: "Failed to bind to port"
- Vérifiez que le code utilise `$PORT` (déjà fait)

### Erreur: "Model not found"
- Vérifiez que les fichiers .pkl sont dans GitHub
- Vérifiez le chemin dans `prediction.py`

### API lente au premier appel
- Normal sur le plan gratuit (cold start)
- Prenez-en compte dans la vidéo de démonstration

---

**🎉 Félicitations! Votre API est maintenant publique et accessible depuis n'importe où!**

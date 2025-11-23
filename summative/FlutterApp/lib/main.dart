import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Rating Predictor',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurple.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.blue.shade50,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with animation effect
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.star_rate_rounded,
                      size: 80,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Title
                  const Text(
                    'Mobile App Rating',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Text(
                    'Prediction System',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      'Harness the power of machine learning to predict app ratings based on key features',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Features Card
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildFeatureRow(Icons.psychology, 'AI-Powered Analysis'),
                          const SizedBox(height: 12),
                          _buildFeatureRow(Icons.speed, 'Instant Predictions'),
                          const SizedBox(height: 12),
                          _buildFeatureRow(Icons.verified, 'High Accuracy Model'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Main CTA Button
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PredictionScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor: Colors.deepPurple.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.trending_up, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Start Prediction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Info text
                  const Text(
                    'Powered by Random Forest ML Model',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  // Text editing controllers for input fields
  final TextEditingController reviewsController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController installsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // State variables
  String selectedType = 'Free';
  bool isLoading = false;
  String? predictionResult;
  String? errorMessage;

  // API endpoint - Deployed on Render
  final String apiUrl = 'https://linear-regression-model-gux3.onrender.com/predict';
  // For local testing: 'http://10.0.2.2:8000/predict' (Android emulator)
  // For local testing: 'http://localhost:8000/predict' (iOS simulator)

  @override
  void dispose() {
    reviewsController.dispose();
    sizeController.dispose();
    installsController.dispose();
    priceController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<void> makePrediction() async {
    // Validate inputs
    if (reviewsController.text.isEmpty ||
        sizeController.text.isEmpty ||
        installsController.text.isEmpty ||
        priceController.text.isEmpty ||
        categoryController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
        predictionResult = null;
      });
      return;
    }

    // Parse inputs
    try {
      final reviews = int.parse(reviewsController.text);
      final size = double.parse(sizeController.text);
      final installs = int.parse(installsController.text);
      final price = double.parse(priceController.text);
      final isFree = selectedType == 'Free' ? 1 : 0;
      final category = categoryController.text.trim().toUpperCase();

      // Validate ranges
      if (reviews < 0 || reviews > 100000000) {
        setState(() {
          errorMessage = 'Reviews must be between 0 and 100,000,000';
          predictionResult = null;
        });
        return;
      }

      if (size < 0.1 || size > 500.0) {
        setState(() {
          errorMessage = 'Size must be between 0.1 and 500 MB';
          predictionResult = null;
        });
        return;
      }

      if (installs < 0 || installs > 10000000000) {
        setState(() {
          errorMessage = 'Installs must be between 0 and 10,000,000,000';
          predictionResult = null;
        });
        return;
      }

      if (price < 0.0 || price > 400.0) {
        setState(() {
          errorMessage = 'Price must be between 0 and 400 USD';
          predictionResult = null;
        });
        return;
      }

      if (category.isEmpty) {
        setState(() {
          errorMessage = 'Category cannot be empty';
          predictionResult = null;
        });
        return;
      }

      // Show loading state
      setState(() {
        isLoading = true;
        errorMessage = null;
        predictionResult = null;
      });

      // Prepare request body
      final requestBody = {
        'reviews': reviews,
        'size_mb': size,
        'installs': installs,
        'price': price,
        'is_free': isFree,
        'category': category,
      };

      // Make API request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rating = data['predicted_rating'];
        final modelName = data['model_name'] ?? 'Unknown';
        final confidence = data['confidence'] ?? 'N/A';

        setState(() {
          predictionResult =
              'Predicted Rating: $rating ⭐\n\nModel: $modelName\nConfidence: $confidence';
          errorMessage = null;
        });
      } else {
        final data = json.decode(response.body);
        setState(() {
          errorMessage = 'Error: ${data['detail'] ?? 'Unknown error'}';
          predictionResult = null;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: ${e.toString()}';
        predictionResult = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Predict App Rating',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.tune,
                        size: 48,
                        color: Colors.deepPurple.shade400,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Enter App Features',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in all fields to get a rating prediction',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

            // Reviews TextField
            TextField(
              controller: reviewsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Reviews',
                hintText: 'e.g., 50000',
                helperText: 'Range: 0 - 100,000,000',
                prefixIcon: const Icon(Icons.rate_review, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 18),

            // Size TextField
            TextField(
              controller: sizeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'App Size (MB)',
                hintText: 'e.g., 25.5',
                helperText: 'Range: 0.1 - 500 MB',
                prefixIcon: const Icon(Icons.storage, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 18),

            // Installs TextField
            TextField(
              controller: installsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Installs',
                hintText: 'e.g., 1000000',
                helperText: 'Range: 0 - 10,000,000,000',
                prefixIcon: const Icon(Icons.download, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 18),

            // Price TextField
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Price (USD)',
                hintText: 'e.g., 0.0 (Free) or 4.99',
                helperText: 'Range: \$0.00 - \$400.00',
                prefixIcon: const Icon(Icons.attach_money, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 18),

            // Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(
                labelText: 'App Type',
                helperText: 'Is the app free or paid?',
                prefixIcon: const Icon(Icons.category, color: Colors.deepPurple),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Free',
                  child: Row(
                    children: [
                      Icon(Icons.free_breakfast, size: 20, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Free'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Paid',
                  child: Row(
                    children: [
                      Icon(Icons.payments, size: 20, color: Colors.orange),
                      SizedBox(width: 8),
                      Text('Paid'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 18),

            // Category TextField
            TextField(
              controller: categoryController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: 'Category',
                hintText: 'e.g., GAME, SOCIAL, PRODUCTIVITY',
                helperText: 'App category in uppercase',
                prefixIcon: const Icon(Icons.apps, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 32),

            // Predict Button
            ElevatedButton(
              onPressed: isLoading ? null : makePrediction,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                elevation: 6,
                shadowColor: Colors.deepPurple.withOpacity(0.5),
              ),
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Analyzing...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.psychology, size: 26),
                        SizedBox(width: 12),
                        Text(
                          'Predict Rating',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 32),

            // Result Display Area
            if (predictionResult != null)
              Card(
                elevation: 8,
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.green.shade300, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Prediction Successful!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          predictionResult!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Error Display Area
            if (errorMessage != null)
              Card(
                elevation: 8,
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.red.shade300, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Validation Error',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

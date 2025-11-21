"""
API Testing Script
Run this script to test your deployed API endpoints
"""

import requests
import json

# Update this with your deployed API URL
API_URL = "http://localhost:8000"  # Change to your deployed URL

def test_api():
    print("="*70)
    print("API TESTING SCRIPT")
    print("="*70)
    print(f"\nTesting API at: {API_URL}")
    print("-"*70)
    
    # Test 1: Root endpoint
    print("\n1. Testing GET / (Root endpoint)")
    try:
        response = requests.get(f"{API_URL}/")
        print(f"   Status: {response.status_code}")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    # Test 2: Health check
    print("\n2. Testing GET /health")
    try:
        response = requests.get(f"{API_URL}/health")
        print(f"   Status: {response.status_code}")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    # Test 3: Model info
    print("\n3. Testing GET /model-info")
    try:
        response = requests.get(f"{API_URL}/model-info")
        print(f"   Status: {response.status_code}")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    # Test 4: Valid prediction
    print("\n4. Testing POST /predict (Valid input)")
    try:
        payload = {
            "reviews": 50000,
            "size_mb": 25.5,
            "installs": 1000000,
            "price": 0.0,
            "is_free": 1,
            "category": "GAME"
        }
        response = requests.post(
            f"{API_URL}/predict",
            json=payload,
            headers={"Content-Type": "application/json"}
        )
        print(f"   Status: {response.status_code}")
        print(f"   Input: {json.dumps(payload, indent=2)}")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    # Test 5: Invalid range
    print("\n5. Testing POST /predict (Invalid range - too many reviews)")
    try:
        payload = {
            "reviews": 200000000,  # Exceeds max of 100,000,000
            "size_mb": 25.5,
            "installs": 1000000,
            "price": 0.0,
            "is_free": 1,
            "category": "GAME"
        }
        response = requests.post(
            f"{API_URL}/predict",
            json=payload,
            headers={"Content-Type": "application/json"}
        )
        print(f"   Status: {response.status_code}")
        print(f"   Expected: 422 (Validation Error)")
        if response.status_code == 422:
            print(f"   ✅ Validation working correctly!")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    # Test 6: Invalid type
    print("\n6. Testing POST /predict (Invalid type - string for number)")
    try:
        payload = {
            "reviews": "fifty thousand",  # Should be int
            "size_mb": 25.5,
            "installs": 1000000,
            "price": 0.0,
            "is_free": 1,
            "category": "GAME"
        }
        response = requests.post(
            f"{API_URL}/predict",
            json=payload,
            headers={"Content-Type": "application/json"}
        )
        print(f"   Status: {response.status_code}")
        print(f"   Expected: 422 (Type Validation Error)")
        if response.status_code == 422:
            print(f"   ✅ Type validation working correctly!")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    # Test 7: Missing field
    print("\n7. Testing POST /predict (Missing required field)")
    try:
        payload = {
            "reviews": 50000,
            "size_mb": 25.5,
            "installs": 1000000,
            "price": 0.0,
            "is_free": 1
            # Missing 'category'
        }
        response = requests.post(
            f"{API_URL}/predict",
            json=payload,
            headers={"Content-Type": "application/json"}
        )
        print(f"   Status: {response.status_code}")
        print(f"   Expected: 422 (Missing Field Error)")
        if response.status_code == 422:
            print(f"   ✅ Required field validation working!")
        print(f"   Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
    
    print("\n" + "="*70)
    print("TESTING COMPLETE!")
    print("="*70)
    print("\nIf all tests passed, your API is ready for deployment! 🚀")
    print("\nNext steps:")
    print("1. Deploy to Render/Railway/Heroku")
    print("2. Update API_URL in this script with deployed URL")
    print("3. Run tests again to verify deployment")
    print("4. Update Flutter app with deployed URL")
    print("="*70)

if __name__ == "__main__":
    print("\n" + "="*70)
    print("IMPORTANT: Update API_URL variable before running!")
    print("="*70)
    print(f"Current API_URL: {API_URL}")
    
    response = input("\nPress Enter to continue with testing (or Ctrl+C to cancel): ")
    test_api()

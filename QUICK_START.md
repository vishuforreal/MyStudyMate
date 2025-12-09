# Quick Start Guide - MyStudyMate

## 🚀 Start Backend & Database

### Step 1: Install MongoDB (One-time setup)
**Download:** https://www.mongodb.com/try/download/community
- Install with default settings
- MongoDB will auto-start as a service

### Step 2: Start Backend Server
```bash
cd backend
npm install
npm run dev
```

**Expected Output:**
```
✅ MongoDB Connected: localhost
🚀 Server running on port 5000
```

## 📱 Run Flutter App

### Step 3: Get Flutter Dependencies
```bash
cd my_study_mate_app
flutter pub get
```

### Step 4: Run App
```bash
flutter run
```

## 🔑 Test Login

### Create Admin Account (First Time)
Use Postman or any API client:

**POST** `http://localhost:5000/api/auth/register`
```json
{
  "name": "Admin",
  "email": "admin@mystudymate.com",
  "password": "admin123",
  "phone": "1234567890",
  "course": "BCA"
}
```

### Login Credentials
- **Admin:** admin@mystudymate.com / admin123
- **Test User:** Create via app registration

## 📝 Important Notes

### For Android Emulator:
Change API URL in both service files:
```dart
static const String baseUrl = 'http://10.0.2.2:5000/api';
```

### For Real Device:
1. Find your computer's IP: `ipconfig` (Windows) or `ifconfig` (Mac/Linux)
2. Change API URL:
```dart
static const String baseUrl = 'http://192.168.x.x:5000/api';
```
3. Make sure phone and computer are on same WiFi

## ✅ Verify Setup

### Test Backend:
Open browser: `http://localhost:5000`
Should show: `{"message": "My Study Mate API", "status": "Running"}`

### Test MongoDB:
```bash
mongosh
show dbs
use mystudymate
show collections
```

## 🐛 Troubleshooting

### Backend won't start:
```bash
cd backend
npm install
npm run dev
```

### MongoDB not running:
```bash
net start MongoDB
```

### Port 5000 already in use:
Edit `backend/.env`:
```
PORT=5001
```
Then update Flutter service files with new port.

### Flutter packages error:
```bash
cd my_study_mate_app
flutter clean
flutter pub get
```

## 📚 Next Steps

1. ✅ Start backend server
2. ✅ Run Flutter app
3. ✅ Register a test user
4. ✅ Login as admin (admin@mystudymate.com / admin123)
5. ✅ Add content via Admin Panel
6. ✅ View content in app

## 🎯 Features Ready

- ✅ User Registration & Login
- ✅ Admin Panel (6 tabs)
- ✅ JWT Authentication
- ✅ MongoDB Database
- ✅ API Integration
- ✅ Screen Protection
- ✅ Search Functionality
- ✅ Free/Paid Content System

Enjoy building! 🚀

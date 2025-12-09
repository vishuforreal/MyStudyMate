# 🚀 Railway Deployment - Step by Step

## 📋 What You Need

- ✅ GitHub account
- ✅ Railway account (free)
- ✅ Your code pushed to GitHub
- ✅ Cloudinary credentials (already have)

---

## 🎯 Step-by-Step Deployment

### Step 1: Prepare Your Code

```bash
# Make sure everything is committed
cd d:\MyStudyMate
git add .
git commit -m "Ready for production deployment"
git push origin main
```

### Step 2: Create Railway Account

1. Go to https://railway.app
2. Click "Login" → "Login with GitHub"
3. Authorize Railway to access GitHub
4. ✅ Account created!

### Step 3: Create New Project

1. Click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose "MyStudyMate" repository
4. Select "backend" folder as root directory
5. Railway starts deploying...

### Step 4: Add MongoDB Database

1. In your project, click "+ New"
2. Select "Database"
3. Choose "Add MongoDB"
4. Wait 30 seconds for database creation
5. ✅ MongoDB ready!

### Step 5: Get MongoDB Connection String

1. Click on MongoDB service
2. Go to "Variables" tab
3. Copy the value of `MONGO_URL`
4. It looks like: `mongodb://mongo:password@containers-us-west-xxx.railway.app:port`

### Step 6: Set Environment Variables

1. Click on your backend service (not MongoDB)
2. Go to "Variables" tab
3. Click "New Variable"
4. Add these 7 variables:

```env
PORT=3000

MONGODB_URI=mongodb://mongo:password@containers-us-west-xxx.railway.app:port
(paste the MONGO_URL you copied)

JWT_SECRET=MyStudyMate2024SecureJWTKey!@#$%^&*()

JWT_EXPIRE=7d

NODE_ENV=production

CLOUDINARY_CLOUD_NAME=dkisaaawx

CLOUDINARY_API_KEY=386444949138948

CLOUDINARY_API_SECRET=18TniHAise9awqQdhmhoLY600po
```

### Step 7: Deploy

1. Railway automatically redeploys after adding variables
2. Wait 2-3 minutes
3. Check "Deployments" tab for status
4. ✅ Deployment successful!

### Step 8: Get Your URL

1. Go to "Settings" tab
2. Scroll to "Domains"
3. Click "Generate Domain"
4. Your URL: `https://your-app-name.up.railway.app`
5. Copy this URL!

### Step 9: Create Admin Account

1. Go to "Settings" tab
2. Scroll to "Service"
3. Click "New Variable" → Add:
   ```
   RUN_ADMIN_SCRIPT=true
   ```
4. Or use Railway CLI:
   ```bash
   railway run node src/scripts/createAdmin.js
   ```

### Step 10: Test Your API

Open browser or Postman:
```
https://your-app-name.up.railway.app/
```

Should return:
```json
{
  "message": "My Study Mate API",
  "status": "Running",
  "version": "1.0.0"
}
```

---

## 🧪 Test All Endpoints

### 1. Test Login
```
POST https://your-app-name.up.railway.app/api/auth/login

Body:
{
  "email": "admin@mystudymate.com",
  "password": "Admin@123"
}
```

### 2. Test Upload
```
POST https://your-app-name.up.railway.app/api/upload

Headers:
Authorization: Bearer <token_from_login>

Body (form-data):
file: [Select PDF]
type: book
```

### 3. Test Create Book
```
POST https://your-app-name.up.railway.app/api/books

Headers:
Authorization: Bearer <token>
Content-Type: application/json

Body:
{
  "title": "Test Book",
  "author": "Test Author",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Test"
}
```

---

## 📱 Update Flutter App

### Change Base URL:

```dart
// lib/services/api_service.dart
class ApiService {
  // Replace with your Railway URL:
  static const String baseUrl = 'https://your-app-name.up.railway.app';
}
```

---

## 🔍 Monitor Your App

### Railway Dashboard:

**Deployments:**
- View deployment logs
- Check build status
- See error messages

**Metrics:**
- CPU usage
- Memory usage
- Request count

**Logs:**
- Real-time logs
- Error tracking
- Debug information

---

## 🐛 Troubleshooting

### Deployment Failed?
```
1. Check "Deployments" tab for errors
2. Verify all environment variables are set
3. Check if package.json has "start" script
4. View logs for specific error messages
```

### Can't Connect to MongoDB?
```
1. Verify MONGODB_URI is correct
2. Check MongoDB service is running
3. Ensure both services are in same project
4. Copy MONGO_URL from MongoDB variables
```

### API Returns 500 Error?
```
1. Check logs in Railway dashboard
2. Verify Cloudinary credentials
3. Test MongoDB connection
4. Check environment variables
```

### Upload Not Working?
```
1. Verify Cloudinary credentials
2. Check file size (max 50MB)
3. Verify JWT token is valid
4. Check logs for specific error
```

---

## 💰 Railway Free Tier Limits

```
✅ 500 hours/month (enough for 24/7)
✅ 512MB RAM
✅ 1GB disk storage
✅ Unlimited bandwidth
✅ Unlimited requests
```

**Your app will run 24/7 for FREE!** 🎉

---

## 📊 What's Deployed

```
Railway Project:
├── Backend Service
│   ├── Node.js + Express
│   ├── All API endpoints
│   ├── File upload handler
│   └── 7 environment variables
│
└── MongoDB Service
    ├── Database
    ├── Collections (users, books, notes, etc.)
    └── Auto-managed by Railway
```

---

## ✅ Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] Railway account created
- [ ] Project created from GitHub repo
- [ ] MongoDB database added
- [ ] All 7 environment variables set
- [ ] Deployment successful
- [ ] Domain generated
- [ ] Admin account created
- [ ] API tested (login, upload, create)
- [ ] Flutter app URL updated
- [ ] Mobile app tested

---

## 🎯 After Deployment

### Your Production URLs:

```
API Base: https://your-app-name.up.railway.app
Login: https://your-app-name.up.railway.app/api/auth/login
Upload: https://your-app-name.up.railway.app/api/upload
Books: https://your-app-name.up.railway.app/api/books
```

### Your Credentials:

```
Admin:
Email: admin@mystudymate.com
Password: Admin@123

Cloudinary:
Dashboard: https://cloudinary.com/console
Cloud Name: dkisaaawx

Railway:
Dashboard: https://railway.app/dashboard
```

---

## 🚀 You're Live!

Your app is now:
- ✅ Running 24/7 on Railway
- ✅ Connected to MongoDB database
- ✅ Integrated with Cloudinary storage
- ✅ Accessible from anywhere
- ✅ Ready for mobile app

**Total Cost: $0/month** 💰

---

**Next: Update Flutter app and test!** 📱

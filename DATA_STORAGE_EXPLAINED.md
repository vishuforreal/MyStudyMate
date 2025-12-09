# 📊 Data Storage Explained - Production Ready

## 🎯 How Your App Stores Data

### Two Storage Systems:

```
┌─────────────────────────────────────────────────────────┐
│                  YOUR APP ARCHITECTURE                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1️⃣  MongoDB (Railway) - Stores TEXT DATA              │
│     ├── User accounts (email, password)                │
│     ├── Admin credentials                              │
│     ├── Book info (title, author, category)            │
│     ├── Note info (title, description)                 │
│     ├── File URLs (links to Cloudinary)                │
│     └── All other text data                            │
│                                                         │
│  2️⃣  Cloudinary - Stores FILES ONLY                    │
│     ├── PDF files (books, notes)                       │
│     ├── PPT files (presentations)                      │
│     ├── ZIP files (projects)                           │
│     └── Returns URL to access files                    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🔐 How User Data is Stored

### MongoDB Stores (Railway):

#### 1. Admin Account
```json
{
  "_id": "507f1f77bcf86cd799439011",
  "name": "Admin",
  "email": "admin@mystudymate.com",
  "password": "$2a$10$hashed_password_here",  // Encrypted!
  "role": "admin",
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

#### 2. Student/User Accounts
```json
{
  "_id": "507f1f77bcf86cd799439012",
  "name": "John Doe",
  "email": "john@example.com",
  "password": "$2a$10$hashed_password_here",  // Encrypted!
  "role": "student",
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

#### 3. Book Information
```json
{
  "_id": "507f1f77bcf86cd799439013",
  "title": "Data Structures",
  "author": "John Smith",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/dkisaaawx/books/abc123.pdf",
  "description": "Complete guide",
  "uploadedBy": "507f1f77bcf86cd799439011",
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

**Note:** Only the URL is stored, not the actual PDF file!

---

## 🔒 Password Security

### How Passwords are Protected:

```javascript
// When user registers:
Plain Password: "MyPassword123"
        ↓
   bcrypt hash
        ↓
Stored in MongoDB: "$2a$10$N9qo8uLOickgx2ZMRZoMye..."

// When user logs in:
User enters: "MyPassword123"
        ↓
   bcrypt compare
        ↓
Matches stored hash? → Login success!
```

**Your passwords are NEVER stored in plain text!** ✅

---

## 📁 How File Upload Works

### Complete Flow:

```
1. User uploads PDF in Flutter app
   ↓
2. Flutter sends file to Railway backend
   POST /api/upload
   ↓
3. Backend uploads file to Cloudinary
   ↓
4. Cloudinary stores file and returns URL
   "https://res.cloudinary.com/dkisaaawx/books/abc123.pdf"
   ↓
5. Backend saves URL in MongoDB
   {
     "title": "My Book",
     "fileUrl": "https://res.cloudinary.com/..."
   }
   ↓
6. User can access file from anywhere using URL
```

---

## 🚀 Railway Production Setup

### Step-by-Step Guide:

### 1️⃣ Create Railway Account
```
1. Go to https://railway.app
2. Sign up with GitHub (free)
3. Verify email
```

### 2️⃣ Create New Project
```
1. Click "New Project"
2. Select "Deploy from GitHub repo"
3. Connect your GitHub account
4. Select MyStudyMate repository
```

### 3️⃣ Add MongoDB Database
```
1. In your project, click "+ New"
2. Select "Database"
3. Choose "MongoDB"
4. Railway creates database automatically
5. Copy the connection string
```

### 4️⃣ Set Environment Variables
```
Click on your service → Variables → Add all 7 variables:
```

**Required Variables:**
```env
PORT=3000
MONGODB_URI=mongodb+srv://mongo:password@containers-us-west-xxx.railway.app
JWT_SECRET=MyStudyMate2024SecureJWTKey!@#$%^&*()
JWT_EXPIRE=7d
NODE_ENV=production
CLOUDINARY_CLOUD_NAME=dkisaaawx
CLOUDINARY_API_KEY=386444949138948
CLOUDINARY_API_SECRET=18TniHAise9awqQdhmhoLY600po
```

### 5️⃣ Deploy
```
1. Push code to GitHub
2. Railway auto-deploys
3. Wait 2-3 minutes
4. Get your URL: https://your-app.railway.app
```

---

## 🧪 Test Your Production Setup

### 1. Create Admin Account
```bash
# After deployment, run this once:
# Railway Dashboard → Service → Settings → Run Command

node src/scripts/createAdmin.js
```

This creates:
```
Email: admin@mystudymate.com
Password: Admin@123
```

### 2. Test Login
```
POST https://your-app.railway.app/api/auth/login

Body:
{
  "email": "admin@mystudymate.com",
  "password": "Admin@123"
}

Response:
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "...",
    "name": "Admin",
    "email": "admin@mystudymate.com",
    "role": "admin"
  }
}
```

### 3. Test User Registration
```
POST https://your-app.railway.app/api/auth/register

Body:
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "Password@123",
  "role": "student"
}
```

### 4. Test File Upload
```
POST https://your-app.railway.app/api/upload

Headers:
Authorization: Bearer <your_token>

Body (form-data):
file: [Select PDF]
type: book

Response:
{
  "success": true,
  "data": {
    "url": "https://res.cloudinary.com/dkisaaawx/books/abc123.pdf"
  }
}
```

### 5. Test Create Book
```
POST https://your-app.railway.app/api/books

Headers:
Authorization: Bearer <your_token>
Content-Type: application/json

Body:
{
  "title": "My First Book",
  "author": "John Smith",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/dkisaaawx/books/abc123.pdf",
  "description": "Test book"
}
```

---

## 📊 What Gets Stored Where

### MongoDB (Railway) - Text Data:
```
✅ User emails
✅ Hashed passwords (encrypted)
✅ User names
✅ User roles (admin/student)
✅ Book titles, authors, categories
✅ Note titles, descriptions
✅ Test questions and answers
✅ File URLs (links to Cloudinary)
✅ Timestamps
```

### Cloudinary - Files Only:
```
✅ PDF files (books, notes)
✅ PPT files (presentations)
✅ DOC files (documents)
✅ ZIP files (projects)
✅ Images (if any)
```

---

## 🔍 View Your Data

### MongoDB Data (Railway):
```
1. Go to Railway Dashboard
2. Click on MongoDB service
3. Click "Data" tab
4. Browse collections:
   - users (all user accounts)
   - books (book information)
   - notes (note information)
   - tests, ppts, assignments, projects
```

### Cloudinary Files:
```
1. Go to https://cloudinary.com/console
2. Click "Media Library"
3. See all uploaded files organized by folder:
   - mystudymate/books/
   - mystudymate/notes/
   - mystudymate/ppts/
```

---

## 🔐 Security in Production

### Passwords:
- ✅ Hashed with bcrypt (10 rounds)
- ✅ Never stored in plain text
- ✅ Cannot be reversed

### JWT Tokens:
- ✅ Signed with secret key
- ✅ Expires in 7 days
- ✅ Required for protected routes

### File Access:
- ✅ Cloudinary URLs are secure
- ✅ Files accessible only via URL
- ✅ No direct file system access

### Environment Variables:
- ✅ Stored securely in Railway
- ✅ Not exposed in code
- ✅ Not in Git repository

---

## 📱 Flutter App Configuration

### Update API Base URL:
```dart
// lib/services/api_service.dart
class ApiService {
  // Change this after Railway deployment:
  static const String baseUrl = 'https://your-app.railway.app';
  
  // For local testing:
  // static const String baseUrl = 'http://localhost:3000';
}
```

---

## 🎯 Production Checklist

### Before Deployment:
- [x] MongoDB connection string ready
- [x] Cloudinary credentials ready
- [x] All 7 environment variables prepared
- [x] Code pushed to GitHub
- [ ] Railway project created
- [ ] Environment variables set in Railway
- [ ] Deployment successful

### After Deployment:
- [ ] Create admin account
- [ ] Test login endpoint
- [ ] Test user registration
- [ ] Test file upload
- [ ] Test create book/note
- [ ] Update Flutter app URL
- [ ] Test from mobile app

---

## 💡 Common Questions

### Q: Where is admin password stored?
**A:** In MongoDB, hashed with bcrypt. Never in plain text.

### Q: Where are student passwords stored?
**A:** Same as admin - in MongoDB, encrypted.

### Q: Where are PDF files stored?
**A:** On Cloudinary servers. MongoDB only stores the URL.

### Q: Can I see passwords in Railway?
**A:** No, they're encrypted. You can only reset them.

### Q: How do I add more admins?
**A:** Register user, then update their role to "admin" in MongoDB.

### Q: What if I forget admin password?
**A:** Run createAdmin.js script again or reset in MongoDB.

---

## 🚀 Quick Deploy Commands

```bash
# 1. Commit your code
git add .
git commit -m "Ready for production"
git push origin main

# 2. Railway auto-deploys

# 3. Create admin (in Railway console)
node src/scripts/createAdmin.js

# 4. Test
curl https://your-app.railway.app/
```

---

## 📊 Data Flow Summary

```
User Registration:
Flutter → Railway API → MongoDB (stores hashed password)

User Login:
Flutter → Railway API → MongoDB (verifies password) → Returns JWT

File Upload:
Flutter → Railway API → Cloudinary (stores file) → Returns URL
                     → MongoDB (stores URL)

Get Books:
Flutter → Railway API → MongoDB (gets book info with URLs)
                     → Flutter displays books
                     → User clicks → Opens Cloudinary URL
```

---

## ✅ Your Production Setup

```
Railway (Free Tier):
├── Node.js Backend (your API)
├── MongoDB Database
│   ├── users collection (emails, passwords)
│   ├── books collection (info + URLs)
│   ├── notes collection (info + URLs)
│   └── other collections
└── Environment Variables (7 variables)

Cloudinary (Free Tier):
└── File Storage (25GB)
    ├── mystudymate/books/
    ├── mystudymate/notes/
    └── mystudymate/ppts/
```

**Total Cost: $0/month** 💰

---

**Ready to deploy? Follow the steps above!** 🚀

# ⚡ Quick Commands Reference

## 🚀 Start Backend

```bash
cd backend
npm start
```

---

## 🧪 Test Cloudinary

```bash
cd backend
npm run test-cloudinary
```

---

## 🔐 Login (Postman)

```
POST http://localhost:3000/api/auth/login

Body:
{
  "email": "admin@mystudymate.com",
  "password": "Admin@123"
}
```

---

## 📤 Upload File (Postman)

```
POST http://localhost:3000/api/upload

Headers:
Authorization: Bearer <your_token>

Body (form-data):
file: [Select file]
type: book
```

---

## 📚 Create Book (Postman)

```
POST http://localhost:3000/api/books

Headers:
Authorization: Bearer <your_token>
Content-Type: application/json

Body:
{
  "title": "My Book",
  "author": "John Doe",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Book description"
}
```

---

## 📖 Get All Books

```
GET http://localhost:3000/api/books
```

---

## 🔍 Get Books by Category

```
GET http://localhost:3000/api/books?category=Engineering
```

---

## 🚀 Deploy to Railway

```bash
git add .
git commit -m "Deploy to production"
git push
```

---

## 📱 Build Flutter APK

```bash
cd my_study_mate_app
flutter build apk --release
```

---

## 🌐 Important URLs

- **Cloudinary Dashboard:** https://cloudinary.com/console
- **Railway Dashboard:** https://railway.app/dashboard
- **Local API:** http://localhost:3000
- **Railway API:** https://your-app.railway.app

---

## 🔑 Credentials

### Admin
```
Email: admin@mystudymate.com
Password: Admin@123
```

### Cloudinary
```
Cloud Name: dkisaaawx
API Key: 386444949138948
```

---

## 📊 Check Status

### Backend Status
```
GET http://localhost:3000/
```

### Cloudinary Status
```bash
npm run test-cloudinary
```

---

## 🛠️ Troubleshooting

### Backend won't start?
```bash
cd backend
npm install
npm start
```

### Upload fails?
```bash
# Check Cloudinary connection
npm run test-cloudinary

# Check token
# Make sure you're logged in
```

### Can't connect to MongoDB?
```bash
# Check .env file
# Verify MONGODB_URI is set
```

---

## 📚 Documentation

- **START_HERE.md** - Main guide
- **README_CLOUDINARY.md** - Cloudinary overview
- **API_QUICK_REFERENCE.md** - All endpoints
- **UPLOAD_FEATURE_GUIDE.md** - Flutter code

---

## ⚡ One-Liners

```bash
# Test everything
cd backend && npm run test-cloudinary && npm start

# Deploy
git add . && git commit -m "Deploy" && git push

# Build APK
cd my_study_mate_app && flutter build apk

# Install dependencies
cd backend && npm install
```

---

**Quick Help: See START_HERE.md** 🚀

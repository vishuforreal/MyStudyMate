# Database & Authentication Setup Guide

## Step 1: Install MongoDB

### Option A: MongoDB Atlas (Cloud - Recommended for Production)
1. Go to https://www.mongodb.com/cloud/atlas
2. Create free account
3. Create a cluster (Free M0 tier)
4. Click "Connect" → "Connect your application"
5. Copy connection string like: `mongodb+srv://username:password@cluster.mongodb.net/mystudymate`
6. Update `backend/.env` file with this connection string

### Option B: MongoDB Local (For Development)
1. Download MongoDB Community Server: https://www.mongodb.com/try/download/community
2. Install MongoDB (default settings)
3. MongoDB will run on `mongodb://localhost:27017`
4. Your `.env` already has this configured

## Step 2: Install Backend Dependencies

```bash
cd backend
npm install
```

## Step 3: Start MongoDB (If using local)

**Windows:**
- MongoDB service starts automatically after installation
- Or run: `net start MongoDB`

**Check if running:**
```bash
mongosh
# If it connects, MongoDB is running
```

## Step 4: Start Backend Server

```bash
cd backend
npm run dev
```

You should see:
```
✅ MongoDB Connected: localhost
🚀 Server running on port 5000
```

## Step 5: Connect Flutter App to Backend

### Install HTTP package in Flutter:
```bash
cd my_study_mate_app
flutter pub add http
flutter pub add shared_preferences
```

## Step 6: Test API Endpoints

### Register User:
```bash
POST http://localhost:5000/api/auth/register
Body: {
  "name": "Test User",
  "email": "test@example.com",
  "password": "123456",
  "phone": "1234567890",
  "course": "BCA"
}
```

### Login:
```bash
POST http://localhost:5000/api/auth/login
Body: {
  "email": "test@example.com",
  "password": "123456"
}
```

### Admin Login:
```bash
POST http://localhost:5000/api/auth/login
Body: {
  "email": "admin@mystudymate.com",
  "password": "admin123"
}
```

## Step 7: API Endpoints Available

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user (requires token)

### Notes
- `GET /api/notes` - Get all notes
- `GET /api/notes/:id` - Get single note
- `POST /api/notes` - Create note (admin only)
- `PUT /api/notes/:id` - Update note (admin only)
- `DELETE /api/notes/:id` - Delete note (admin only)

### Books
- `GET /api/books` - Get all books
- `GET /api/books/:id` - Get single book
- `POST /api/books` - Create book (admin only)
- `PUT /api/books/:id` - Update book (admin only)
- `DELETE /api/books/:id` - Delete book (admin only)

### Tests
- `GET /api/tests` - Get all tests
- `GET /api/tests/:id` - Get single test
- `POST /api/tests` - Create test (admin only)
- `PUT /api/tests/:id` - Update test (admin only)
- `DELETE /api/tests/:id` - Delete test (admin only)

## Step 8: Flutter Integration

The Flutter app will use:
- `http` package to make API calls
- `shared_preferences` to store JWT token
- API base URL: `http://localhost:5000/api` (development)

## Troubleshooting

### MongoDB Connection Error:
- Check if MongoDB service is running
- Verify connection string in `.env`
- For Atlas: Check IP whitelist (allow 0.0.0.0/0 for testing)

### Backend Not Starting:
```bash
cd backend
npm install
npm run dev
```

### Port Already in Use:
- Change PORT in `.env` to 5001 or another port
- Update Flutter API base URL accordingly

## Production Deployment

### Backend:
- Deploy to Heroku, Railway, or AWS
- Use MongoDB Atlas for database
- Update `.env` with production values

### Flutter App:
- Update API base URL to production URL
- Build release APK

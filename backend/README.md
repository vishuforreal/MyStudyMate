# My Study Mate - Backend API

Fast and scalable Node.js backend for My Study Mate app.

## 🚀 Features

- User Authentication (Register/Login with JWT)
- Notes Management
- Chapter-wise Tests
- Reference Books
- User Profile Management
- Subscription System
- Secure API with JWT tokens

## 📦 Tech Stack

- **Node.js** - Fast JavaScript runtime
- **Express.js** - Web framework
- **MongoDB** - Database
- **JWT** - Authentication
- **Bcrypt** - Password hashing

## 🛠️ Installation

### 1. Install Node.js
Download from: https://nodejs.org (LTS version)

### 2. Install MongoDB
Download from: https://www.mongodb.com/try/download/community

### 3. Install Dependencies

```bash
cd backend
npm install
```

### 4. Setup Environment Variables

Edit `.env` file:
```
PORT=5000
MONGODB_URI=mongodb://localhost:27017/mystudymate
JWT_SECRET=your_secret_key
```

### 5. Run Server

```bash
# Development mode
npm run dev

# Production mode
npm start
```

Server will run on: http://localhost:5000

## 📡 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user

### Notes
- `GET /api/notes` - Get all notes
- `GET /api/notes/:id` - Get single note
- `POST /api/notes` - Create note (admin)

### Tests
- `GET /api/tests` - Get all tests
- `GET /api/tests/:id` - Get single test

### Books
- `GET /api/books` - Get all books
- `GET /api/books/:id` - Get single book

### Users
- `PUT /api/users/profile` - Update profile

### Courses
- `GET /api/courses` - Get all courses

## 🔐 Authentication

All protected routes require JWT token in header:
```
Authorization: Bearer <token>
```

## 📝 Example Requests

### Register User
```bash
POST http://localhost:5000/api/auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "123456",
  "course": "BCA"
}
```

### Login
```bash
POST http://localhost:5000/api/auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "123456"
}
```

### Get Notes
```bash
GET http://localhost:5000/api/notes?course=BCA&subject=C Programming
Authorization: Bearer <your_token>
```

## 🗄️ Database Models

### User
- name, email, password
- course, semester
- subscription (plan, dates, status)

### Note
- title, subject, course, chapter
- content, fileUrl
- isPremium, views

### Test
- title, subject, course, chapter
- questions, duration, totalMarks
- isPremium

### Book
- title, author, subject, course
- description, coverImage, fileUrl
- isPremium, downloads

## 🚀 Deployment

### Deploy to Heroku/Railway/Render
1. Push code to GitHub
2. Connect to hosting platform
3. Set environment variables
4. Deploy!

## 📊 Performance

- Fast response times (<100ms)
- Scalable architecture
- JWT-based stateless auth
- MongoDB indexing for speed

## 🔒 Security

- Password hashing with bcrypt
- JWT token authentication
- CORS enabled
- Input validation
- Protected routes

---

**Backend is ready! Connect it to your Flutter app!** 🎉

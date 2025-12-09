# 🚀 API Quick Reference

## Base URL
- **Local:** `http://localhost:3000`
- **Railway:** `https://your-app.railway.app`

---

## 🔐 Authentication

### Register
```
POST /api/auth/register
Body: {
  "name": "John Doe",
  "email": "john@example.com",
  "password": "Password@123",
  "role": "student"
}
```

### Login
```
POST /api/auth/login
Body: {
  "email": "admin@mystudymate.com",
  "password": "Admin@123"
}
Response: { "token": "eyJhbGc..." }
```

---

## 📤 File Upload (Cloudinary)

### Upload File
```
POST /api/upload
Headers: Authorization: Bearer <token>
Body (multipart/form-data):
  - file: <your_file>
  - type: book|note|ppt|test|assignment|project

Response: {
  "success": true,
  "data": {
    "url": "https://res.cloudinary.com/...",
    "publicId": "mystudymate/books/abc123",
    "format": "pdf",
    "size": 1234567
  }
}
```

### Delete File
```
DELETE /api/upload
Headers: Authorization: Bearer <token>
Body: { "publicId": "mystudymate/books/abc123" }
```

---

## 📚 Books

### Get All Books
```
GET /api/books
GET /api/books?category=Engineering
```

### Get Single Book
```
GET /api/books/:id
```

### Create Book
```
POST /api/books
Headers: Authorization: Bearer <token>
Body: {
  "title": "Data Structures",
  "author": "John Doe",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Complete guide"
}
```

### Update Book
```
PUT /api/books/:id
Headers: Authorization: Bearer <token>
Body: { "title": "Updated Title" }
```

### Delete Book
```
DELETE /api/books/:id
Headers: Authorization: Bearer <token>
```

---

## 📝 Notes

### Get All Notes
```
GET /api/notes
GET /api/notes?category=Engineering&course=CSE
```

### Create Note
```
POST /api/notes
Headers: Authorization: Bearer <token>
Body: {
  "title": "Chapter 1 Notes",
  "category": "Engineering",
  "course": "CSE",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Important notes"
}
```

---

## 📊 Tests

### Get All Tests
```
GET /api/tests
GET /api/tests?category=Engineering
```

### Create Test
```
POST /api/tests
Headers: Authorization: Bearer <token>
Body: {
  "title": "Mid Term Test",
  "category": "Engineering",
  "course": "CSE",
  "questions": [...],
  "duration": 60
}
```

---

## 🎯 PPTs

### Get All PPTs
```
GET /api/ppts
GET /api/ppts?category=Engineering
```

### Create PPT
```
POST /api/ppts
Headers: Authorization: Bearer <token>
Body: {
  "title": "Introduction to AI",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "AI basics"
}
```

---

## 📋 Assignments

### Get All Assignments
```
GET /api/assignments
```

### Create Assignment
```
POST /api/assignments
Headers: Authorization: Bearer <token>
Body: {
  "title": "Assignment 1",
  "category": "Engineering",
  "dueDate": "2024-12-31",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Complete by deadline"
}
```

---

## 🚀 Projects

### Get All Projects
```
GET /api/projects
```

### Create Project
```
POST /api/projects
Headers: Authorization: Bearer <token>
Body: {
  "title": "Final Year Project",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Project details"
}
```

---

## 👥 Admin Routes

### Get All Users
```
GET /api/admin/users
Headers: Authorization: Bearer <admin_token>
```

### Delete User
```
DELETE /api/admin/users/:id
Headers: Authorization: Bearer <admin_token>
```

---

## 📱 Flutter Example

```dart
// Upload File
Future<String> uploadFile(File file, String type) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrl/api/upload'),
  );
  
  request.headers['Authorization'] = 'Bearer $token';
  request.fields['type'] = type;
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  
  var response = await request.send();
  var data = json.decode(await response.stream.bytesToString());
  return data['data']['url'];
}

// Create Book
Future<void> createBook(String title, String fileUrl) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/books'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'title': title,
      'fileUrl': fileUrl,
      'category': 'Engineering',
    }),
  );
}
```

---

## 🔑 Default Admin Credentials

```
Email: admin@mystudymate.com
Password: Admin@123
```

---

## ✅ Status Codes

- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `404` - Not Found
- `500` - Server Error

---

## 📊 Response Format

### Success
```json
{
  "success": true,
  "data": {...}
}
```

### Error
```json
{
  "message": "Error description"
}
```

---

**Happy Coding! 🚀**

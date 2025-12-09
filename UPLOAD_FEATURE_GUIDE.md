# 📤 File Upload Feature Guide

## 🎯 Overview

Your app now supports cloud file uploads using Cloudinary with 25GB free storage!

---

## 🔧 How It Works

```
User selects file → Flutter app uploads to backend → Backend uploads to Cloudinary → Returns URL → Save URL in MongoDB
```

---

## 📱 Flutter Implementation

### Step 1: Add Dependencies
```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0
  file_picker: ^6.1.1
```

### Step 2: Create Upload Service
```dart
// lib/services/upload_service.dart
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadService {
  static const String baseUrl = 'https://your-app.railway.app';
  
  static Future<String> uploadFile({
    required File file,
    required String type, // book, note, ppt, test, assignment, project
    required String token,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/upload'),
      );
      
      // Add headers
      request.headers['Authorization'] = 'Bearer $token';
      
      // Add fields
      request.fields['type'] = type;
      
      // Add file
      request.files.add(
        await http.MultipartFile.fromPath('file', file.path),
      );
      
      // Send request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);
      
      if (response.statusCode == 200) {
        return jsonData['data']['url']; // Cloudinary URL
      } else {
        throw Exception(jsonData['message'] ?? 'Upload failed');
      }
    } catch (e) {
      throw Exception('Upload error: $e');
    }
  }
}
```

### Step 3: Create Book with File Upload
```dart
// lib/services/book_service.dart
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'upload_service.dart';

class BookService {
  static const String baseUrl = 'https://your-app.railway.app';
  
  static Future<void> createBook({
    required File file,
    required String title,
    required String author,
    required String category,
    required String description,
    required String token,
  }) async {
    try {
      // 1. Upload file to Cloudinary
      String fileUrl = await UploadService.uploadFile(
        file: file,
        type: 'book',
        token: token,
      );
      
      // 2. Create book with Cloudinary URL
      final response = await http.post(
        Uri.parse('$baseUrl/api/books'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'author': author,
          'category': category,
          'description': description,
          'fileUrl': fileUrl, // Cloudinary URL
        }),
      );
      
      if (response.statusCode != 201) {
        throw Exception('Failed to create book');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

### Step 4: UI Implementation
```dart
// lib/screens/add_book_screen.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  File? _selectedFile;
  bool _isUploading = false;
  
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }
  
  Future<void> _uploadBook() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a file')),
      );
      return;
    }
    
    setState(() => _isUploading = true);
    
    try {
      await BookService.createBook(
        file: _selectedFile!,
        title: _titleController.text,
        author: _authorController.text,
        category: 'Engineering',
        description: _descriptionController.text,
        token: 'YOUR_TOKEN', // Get from auth service
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book uploaded successfully!')),
      );
      
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Book')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: Icon(Icons.attach_file),
              label: Text(_selectedFile == null 
                ? 'Select PDF File' 
                : 'File: ${_selectedFile!.path.split('/').last}'),
            ),
            SizedBox(height: 20),
            _isUploading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _uploadBook,
                  child: Text('Upload Book'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎯 Supported File Types

### Books
- PDF files
- Max size: 50MB

### Notes
- PDF files
- Max size: 50MB

### PPTs
- PPT, PPTX files
- Max size: 50MB

### Tests
- JSON files
- Max size: 10MB

### Assignments
- PDF, DOC, DOCX files
- Max size: 50MB

### Projects
- ZIP, RAR files
- Max size: 50MB

---

## 🔒 Security

- All uploads require authentication (JWT token)
- File type validation on backend
- File size limits enforced
- Cloudinary provides secure URLs

---

## 📊 Upload Flow

1. **User selects file** in Flutter app
2. **Flutter sends file** to backend API
3. **Backend validates** file type and size
4. **Backend uploads** to Cloudinary
5. **Cloudinary returns** secure URL
6. **Backend saves** URL in MongoDB
7. **Flutter receives** success response

---

## 🧪 Testing Upload

### Using Postman

1. **Login to get token:**
```
POST http://localhost:3000/api/auth/login
Body: {
  "email": "admin@mystudymate.com",
  "password": "Admin@123"
}
```

2. **Upload file:**
```
POST http://localhost:3000/api/upload
Headers: 
  Authorization: Bearer <your_token>
Body (form-data):
  file: [Select your PDF file]
  type: book
```

3. **Create book with URL:**
```
POST http://localhost:3000/api/books
Headers:
  Authorization: Bearer <your_token>
  Content-Type: application/json
Body: {
  "title": "Test Book",
  "author": "John Doe",
  "category": "Engineering",
  "fileUrl": "https://res.cloudinary.com/...",
  "description": "Test description"
}
```

---

## 💡 Pro Tips

### 1. Show Upload Progress
```dart
var request = http.MultipartRequest('POST', uri);
var response = await request.send();

response.stream.listen((value) {
  // Calculate progress
  double progress = value.length / totalBytes;
  print('Upload progress: ${(progress * 100).toStringAsFixed(0)}%');
});
```

### 2. Compress Files Before Upload
```dart
// Use flutter_image_compress for images
// Use pdf_compressor for PDFs
```

### 3. Cache Cloudinary URLs
```dart
// Save URLs locally to avoid re-downloading
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('book_url_$bookId', cloudinaryUrl);
```

### 4. Handle Network Errors
```dart
try {
  await uploadFile();
} on SocketException {
  print('No internet connection');
} on TimeoutException {
  print('Upload timeout');
} catch (e) {
  print('Upload error: $e');
}
```

---

## 🐛 Common Issues

### Issue: "No file uploaded"
**Solution:** Make sure field name is `file` in multipart request

### Issue: "File too large"
**Solution:** Compress file or reduce size to under 50MB

### Issue: "Unauthorized"
**Solution:** Include valid JWT token in Authorization header

### Issue: "Invalid file type"
**Solution:** Check allowed extensions in backend

---

## 📈 Monitor Usage

### Cloudinary Dashboard
- Go to: https://cloudinary.com/console
- Check storage: 0/25GB
- Check bandwidth: 0/25GB

### Railway Dashboard
- Monitor API requests
- Check response times
- View error logs

---

## 🎉 You're Ready!

Your app can now:
- ✅ Upload files to cloud (Cloudinary)
- ✅ Store URLs in database (MongoDB)
- ✅ Download files from anywhere
- ✅ Handle 25GB of files for free

---

**Happy Uploading! 🚀**

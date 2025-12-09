import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class UploadService {
  static const String baseUrl = 'http://10.0.2.2:3000/api';

  static Future<String?> uploadFile(File file) async {
    try {
      final token = await AuthService.getToken();
      final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
      
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        final data = json.decode(responseData);
        return data['fileUrl'];
      }
      
      throw Exception('Upload failed');
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  // For Android emulator use:
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  
  // For real device use your computer's IP:
  // static const String baseUrl = 'http://192.168.x.x:3000/api';
  
  // For production use:
  // static const String baseUrl = 'https://YOUR-RAILWAY-URL.up.railway.app/api';

  static Future<Map<String, String>> _getHeaders() async {
    final token = await AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Notes
  static Future<List<dynamic>> getNotes({String? category, String? course}) async {
    final queryParams = <String, String>{};
    if (category != null) queryParams['category'] = category;
    if (course != null) queryParams['course'] = course;
    
    final uri = Uri.parse('$baseUrl/notes').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders());
    
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    }
    throw Exception('Failed to load notes');
  }

  static Future<Map<String, dynamic>> createNote(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: await _getHeaders(),
      body: json.encode(data),
    );
    
    if (response.statusCode == 201) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create note');
  }

  // Books
  static Future<List<dynamic>> getBooks({String? category}) async {
    final queryParams = category != null ? {'category': category} : <String, String>{};
    final uri = Uri.parse('$baseUrl/books').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders());
    
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    }
    throw Exception('Failed to load books');
  }

  static Future<Map<String, dynamic>> createBook(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books'),
      headers: await _getHeaders(),
      body: json.encode(data),
    );
    
    if (response.statusCode == 201) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create book');
  }

  // Tests
  static Future<List<dynamic>> getTests({String? category, String? course}) async {
    final queryParams = <String, String>{};
    if (category != null) queryParams['category'] = category;
    if (course != null) queryParams['course'] = course;
    
    final uri = Uri.parse('$baseUrl/tests').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: await _getHeaders());
    
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    }
    throw Exception('Failed to load tests');
  }

  static Future<Map<String, dynamic>> createTest(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tests'),
      headers: await _getHeaders(),
      body: json.encode(data),
    );
    
    if (response.statusCode == 201) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create test');
  }
}

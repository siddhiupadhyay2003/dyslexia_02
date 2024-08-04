import 'dart:convert';

// to communicate wirh server
import 'package:http/http.dart' as http;

// to access jwt token
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = 'http://127.0.0.1:8000/api/';
  final storage = FlutterSecureStorage();

  Future<bool> register(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse('${baseUrl}register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );
    return response.statusCode == 201;
  }

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Access Token: ${data['access']}');
      print('Refresh Token: ${data['refresh']}');
      
      try {
        await storage.write(key: 'access', value: data['access']);
        await storage.write(key: 'refresh', value: data['refresh']);
        print('Tokens stored successfully.');
      } catch (e) {
        print('Error storing tokens: $e');
      }
      return true;
    } else {
      print('Login failed: ${response.statusCode}');
      return false;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'access');
    await storage.delete(key: 'refresh');
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access');
  }
}
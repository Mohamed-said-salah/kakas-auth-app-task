import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthAPI {
  static const String baseUrl = 'https://dev.kakas.app/xo/api';

  // Login API request
  static Future<Map<String, dynamic>?> login(
      String userName, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': userName, 'password': password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Register API request
  static Future<Map<String, dynamic>?> register(
      String userName, String password, referrerCode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': userName,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Get user information (after token load)
  static Future<Map<String, dynamic>?> getMe(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me?token=$token'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}

// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';  // Zorg dat Config.apiUrl hier staat

class AuthService {
  static Future<bool> login(String email, String password) async {
    final resp = await http.post(
      Uri.parse('${Config.apiUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return true;
    }
    return false;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = "https://localhost:7027";
  static const String _loginUrl = "/api/Auth/login";

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
   final data = jsonDecode(response.body);
    if (data['accessToken'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['accessToken']);
      return true;
    }
    return false;
  } else {
    return false;
  }
}

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

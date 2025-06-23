import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _email;

  bool get isLoggedIn => _token != null;
  String? get token => _token;
  String? get email => _email;

  /// Call Laravel `/login`, store Bearer token on success.
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/login');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      _token = body['access_token'];
      _email = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Call Laravel `/logout`, clear token.
  Future<void> logout() async {
    if (_token != null) {
      final url = Uri.parse('http://10.0.2.2:8000/api/logout');
      await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
    }
    _token = null;
    _email = null;
    notifyListeners();
  }
}

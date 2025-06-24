import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _email;
  String? _name;

  bool get isLoggedIn => _token != null;
  String? get token   => _token;
  String  get email   => _email ?? '';
  String  get name    => _name  ?? '';

  /// Call Laravel `/login`, store Bearer token & real user name.
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

      // parse the returned user object
      final user = body['user'] as Map<String, dynamic>;
      _email = user['email'] as String;
      _name  = user['name']  as String;

      notifyListeners();
      return true;
    }

    return false;
  }

  /// Optional: refresh user info from /user endpoint
  Future<void> fetchUserProfile() async {
    if (_token == null) return;
    final url = Uri.parse('http://10.0.2.2:8000/api/user');
    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_token'},
    );
    if (resp.statusCode == 200) {
      final user = jsonDecode(resp.body) as Map<String, dynamic>;
      _email = user['email'] as String;
      _name  = user['name']  as String;
      notifyListeners();
    }
  }

  /// Call Laravel `/logout`, clear token.
  Future<void> logout() async {
    if (_token != null) {
      final url = Uri.parse('http://10.0.2.2:8000/api/logout');
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
    }
    _token = null;
    _email = null;
    _name  = null;
    notifyListeners();
  }
}

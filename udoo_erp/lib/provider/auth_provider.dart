import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  int? _currentUserId = 1;
  String? _token;

  int? get userId => _currentUserId;
  String? get token => _token;

  void setUserId(int id) {
    _currentUserId = id;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      // Uri.parse('http://10.0.2.2:8000/api/login'),
      Uri.parse('http://localhost:8000/api/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _currentUserId = data['user']['id'];
      _token = data['token'];

      notifyListeners();
      return true;
    }
    return false;
  }
}

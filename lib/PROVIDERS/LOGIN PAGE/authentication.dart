// PROVIDER CLASS - auth_provider.dart
import 'package:flutter/material.dart';
import 'package:gym_user/CORE/API/apiconfig.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.loginUrl), // Replace with your API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print("Response body: ${response.body}"); // Print the response.body);
      print("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {

        
         final data = jsonDecode(response.body);

        /// Tokens
        final accessToken = data['access'];
        final refreshToken = data['refresh'];

        /// Member Data
        final memberData = data['member'];

        /// Save everything
        await SharedPrefService.saveLoginData(
          accessToken: accessToken,
          refreshToken: refreshToken,
          memberData: memberData,
        );

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
  print("LOGIN ERROR: $e");
  _errorMessage = e.toString();
  notifyListeners();
  return false;
}
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
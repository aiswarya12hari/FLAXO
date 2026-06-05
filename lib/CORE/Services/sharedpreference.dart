import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String memberDataKey = 'member_data';

  /// Save Tokens + Member Data
  static Future<void> saveLoginData({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> memberData,
  }) async {
    
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);

    /// Store member object as JSON String
    await prefs.setString(
      memberDataKey,
      jsonEncode(memberData),
    );
  }

  /// Get Access Token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  /// Get Refresh Token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  /// Get Member Data
  static Future<Map<String, dynamic>?> getMemberData() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(memberDataKey);

    if (data != null) {
      return jsonDecode(data);
    }

    return null;
  }
/// Validate Access Token
static Future<bool> validateAccessToken() async {
  try {
    final token = await getAccessToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    final response = await http.get(
      Uri.parse(
        'https://gymsoftware.archanastones.in/api/user/checkin/status/',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    debugPrint(
      'TOKEN VALIDATION RESPONSE: ${response.statusCode}',
    );

    /// Token valid
    if (response.statusCode == 200) {
      return true;
    }

    /// Token expired
    if (response.statusCode == 401) {
      final refreshed =
          await refreshAccessToken();

      return refreshed;
    }

    return false;
  } catch (e) {
    debugPrint('Validate Token Error: $e');

    return false;
  }
}
 static Future<bool> refreshAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final refreshToken = prefs.getString(refreshTokenKey);

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await http.post(
        Uri.parse(
          'https://gymsoftware.archanastones.in/api/user/token/refresh/',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refresh': refreshToken,
        }),
      );

      print('REFRESH RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          await prefs.setString(
            accessTokenKey,
            data['access'],
          );

          await prefs.setString(
            refreshTokenKey,
            data['refresh'],
          );

          return true;
        }
      }

      return false;
    } catch (e) {
      print('TOKEN REFRESH ERROR: $e');

      return false;
    }
  }
  /// Logout / Clear Data
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(memberDataKey);
  }
}
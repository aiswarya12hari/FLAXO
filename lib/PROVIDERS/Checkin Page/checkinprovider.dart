import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckinProvider with ChangeNotifier {
  bool _isCheckedIn = false;

  String _checkInTime = '--:--';

  Map<String, dynamic>? _memberData;

  /// Getters
  bool get isCheckedIn => _isCheckedIn;

  String get checkInTime => _checkInTime;

  Map<String, dynamic>? get memberData => _memberData;

  /// User Name
  String get userName {
    if (_memberData == null) {
      return 'User';
    }

    final firstName = _memberData?['first_name'] ?? '';

    final lastName = _memberData?['last_name'] ?? '';

    return '$firstName $lastName';
  }

  /// Gym Name
  String get gymName {
    if (_memberData == null) {
      return 'Gym';
    }

    return _memberData?['gym_name'] ?? 'Gym';
  }

  /// Load User Data
  Future<void> loadUserData() async {
    _memberData = await SharedPrefService.getMemberData();

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('check_in_time');

    await checkCheckinStatus();

    notifyListeners();
  }

  /// CHECK CHECK-IN STATUS FROM API
  Future<void> checkCheckinStatus() async {
    try {
      final token = await SharedPrefService.getAccessToken();

      if (token == null || token.isEmpty) {
        return;
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

      debugPrint('STATUS API RESPONSE: ${response.body}');
      if (response.statusCode == 401) {
        final refreshed = await SharedPrefService.refreshAccessToken();

        if (refreshed) {
          await checkCheckinStatus();
          return;
        } else {
          await SharedPrefService.clearData();
          return;
        }
      }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          _isCheckedIn = data['checked_in'] ?? false;

          final checkin = data['checkin'];

          if (checkin != null && checkin['check_in_time'] != null) {
            final rawTime = checkin['check_in_time'];

            debugPrint('RAW API TIME: $rawTime');

            final dateTime = DateTime.parse(rawTime).toLocal();

            _checkInTime = DateFormat('hh:mm a').format(dateTime);

            debugPrint('FORMATTED TIME: $_checkInTime');

            /// SAVE LOCALLY ALSO
            final prefs = await SharedPreferences.getInstance();

            await prefs.setString('check_in_time', checkin['check_in_time']);
          } else {
            _checkInTime = '--:--';

            final prefs = await SharedPreferences.getInstance();

            await prefs.remove('check_in_time');
          }

          notifyListeners();
        }
      } else {
        debugPrint('Check-in status failed: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Check-in status error: $e');
    }
  }

  /// Load Check-In Time From SharedPreferences
  Future<void> loadCheckInTime() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTime = prefs.getString('check_in_time');

    if (savedTime != null && savedTime.isNotEmpty) {
      final dateTime = DateTime.parse(savedTime);

      _checkInTime = DateFormat('hh:mm a').format(dateTime);

      _isCheckedIn = true;
    } else {
      _checkInTime = '--:--';

      _isCheckedIn = false;
    }

    notifyListeners();
  }

  /// Refresh After Successful Check-In
  Future<void> refreshCheckIn() async {
    await checkCheckinStatus();
  }

  /// Logout
  Future<void> logout() async {
    await SharedPrefService.clearData();

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('check_in_time');

    _memberData = null;

    _isCheckedIn = false;

    _checkInTime = '--:--';

    notifyListeners();
  }
}

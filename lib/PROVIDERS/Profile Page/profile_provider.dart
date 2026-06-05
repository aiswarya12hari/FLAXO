
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gym_user/CORE/API/apiconfig.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'package:http/http.dart' as http;


class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  // Member fields
  int? id;
  String admissionNo = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String bloodGroup = '';
  String gender = '';
  String dateOfBirth = '';
  String presentAddress = '';
  String faceImage1 = '';
  String gymName = '';
  String packageName = '';
  String totalAmount = '';
  String discountAmount = '';
  String finalAmount = '';
  String paidAmount = '';
  String startDate = '';
  String endDate = '';
  String paymentMethod = '';
  String createdAt = '';

  String get fullName => '$firstName $lastName'.trim();

  String get formattedDob {
    if (dateOfBirth.isEmpty) return '';
    try {
      final parts = dateOfBirth.split('-');
      if (parts.length == 3) {
        final months = [
          '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
        ];
        return '${parts[2]} ${months[int.parse(parts[1])]} ${parts[0]}';
      }
    } catch (_) {}
    return dateOfBirth;
  }

  String get membershipStatus {
    if (endDate.isEmpty) return 'Unknown';
    try {
      final end = DateTime.parse(endDate);
      return DateTime.now().isBefore(end) ? 'Active' : 'Expired';
    } catch (_) {
      return 'Unknown';
    }
  }

  int get daysRemaining {
    if (endDate.isEmpty) return 0;
    try {
      final end = DateTime.parse(endDate);
      final diff = end.difference(DateTime.now()).inDays;
      return diff < 0 ? 0 : diff;
    } catch (_) {
      return 0;
    }
  }

  Future<void> loadProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {

      final token = await SharedPrefService.getAccessToken();

      final response = await http.get(
        Uri.parse(ApiConfig.profileUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final m = data['member'];
          id            = m['id'];
          admissionNo   = m['admission_no'] ?? '';
          firstName     = m['first_name'] ?? '';
          lastName      = m['last_name'] ?? '';
          email         = m['email'] ?? '';
          phoneNumber   = m['phone_number'] ?? '';
          bloodGroup    = m['blood_group'] ?? '';
          gender        = m['gender'] ?? '';
          dateOfBirth   = m['date_of_birth'] ?? '';
          presentAddress = m['present_address'] ?? '';
          faceImage1    = m['face_image_1'] ?? '';
          gymName       = m['gym_name'] ?? '';
          packageName   = m['package_name'] ?? '';
          totalAmount   = m['total_amount'] ?? '';
          discountAmount = m['discount_amount'] ?? '';
          finalAmount   = m['final_amount'] ?? '';
          paidAmount    = m['paid_amount'] ?? '';
          startDate     = m['start_date'] ?? '';
          endDate       = m['end_date'] ?? '';
          paymentMethod = m['payment_method'] ?? '';
          createdAt     = m['created_at'] ?? '';
        } else {
          errorMessage = 'Failed to load profile.';
        }
      } else {
        errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Network error. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }
}
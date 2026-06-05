import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? '';
  }

  
  static String get loginUrl {
    return '$baseUrl/api/user/login/';
  }

  static String get checkinUrl {
    return '$baseUrl/api/user/checkin/';
  }

  static String get profileUrl {
    return '$baseUrl/api/user/profile/';
  }

}
import 'package:flutter/material.dart';
import 'package:gym_user/SCREENS/Checkinout/checkinout.dart';
import 'package:gym_user/SCREENS/Login/login_screen.dart';
import 'package:gym_user/SCREENS/Verifications/verification.dart';

class RoutesClass {
  static const String login = '/login';
  static const String verification = '/verification';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const CheckinoutScreen(),

    verification: (context) {
  final Object? arguments =
      ModalRoute.of(context)
          ?.settings
          .arguments;

  Map<String, dynamic> args = {};

  if (arguments != null &&
      arguments is Map<String, dynamic>) {
    args = arguments;
  }

  return VerificationScreen(
    userName:
        args['userName']?.toString() ?? '',

    userAvatar:
        args['userAvatar']?.toString() ?? '',

    isCheckIn:
        args['isCheckIn'] ?? true,
  );
},
  };
}
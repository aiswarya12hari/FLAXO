import 'package:flutter/material.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'package:gym_user/SCREENS/Checkinout/checkinout.dart';
import 'package:gym_user/SCREENS/Login/login_screen.dart';
import 'package:in_app_update/in_app_update.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _checkForUpdate();
    await _navigateAfterDelay();
  }

  Future<void> _checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo =
          await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {

        // Flexible update (background download)
        await InAppUpdate.startFlexibleUpdate();

        // Complete install
        await InAppUpdate.completeFlexibleUpdate();
      }
    } catch (e) {
      debugPrint("Update Error: $e");
    }
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    final token =
        await SharedPrefService.getAccessToken();

    bool isLoggedIn = false;

    if (token != null && token.isNotEmpty) {
      final isValid =
          await SharedPrefService.validateAccessToken();

      if (isValid) {
        isLoggedIn = true;
      }
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => isLoggedIn
            ? const CheckinoutScreen()
            : const LoginScreen(),
        transitionsBuilder:
            (_, animation, __, child) =>
                FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF8C42),
              Color(0xFFFF5500),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.25),
                          blurRadius: 30,
                          offset:
                              const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(32),
                      child: Image.asset(
                        'assets/icon/flaxo logo.jpg.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Flaxo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Your Gym. Your Way.',
                    style: TextStyle(
                      color:
                          Colors.white.withOpacity(0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
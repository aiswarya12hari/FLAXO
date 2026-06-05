import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gym_user/PROVIDERS/Checkin%20Page/checkinprovider.dart';
import 'package:gym_user/PROVIDERS/Login%20Page/authentication.dart';
import 'package:gym_user/PROVIDERS/Profile%20Page/profile_provider.dart';
import 'package:gym_user/ROUTES/routes.dart';
import 'package:gym_user/SCREENS/Splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:gym_user/PROVIDERS/VERIFICATION PAGE/verification_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CheckinProvider()),
        ChangeNotifierProvider(create: (_) => VerificationProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: RoutesClass.routes,
    );
  }
}

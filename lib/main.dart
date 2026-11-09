import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportzone_lib/firebase_options.dart';

import 'core/app_theme.dart';
import 'providers/cart_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const SportZoneApp(),
    ),
  );
}

class SportZoneApp extends StatelessWidget {
  const SportZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportZone',
      debugShowCheckedModeBanner: false,
      theme: buildSportZoneTheme(),
      home: const SplashScreen(),
    );
  }
}

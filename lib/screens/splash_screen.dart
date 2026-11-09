import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/sportzone_logo.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: _RayasPainter(),
        child: const SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SportZoneLogo(),
                SizedBox(height: 6),
                Text(
                  'Tu tienda deportiva',
                  style: TextStyle(fontSize: 11, color: AppColors.textoSecundario),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RayasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final pintura = Paint()..color = AppColors.naranja;

    final arriba = Path()
      ..moveTo(w * 0.55, 0)
      ..lineTo(w * 0.85, 0)
      ..lineTo(0, h * 0.27)
      ..lineTo(0, h * 0.17)
      ..close();
    final abajo = Path()
      ..moveTo(w * 0.45, h)
      ..lineTo(w * 0.15, h)
      ..lineTo(w, h * 0.73)
      ..lineTo(w, h * 0.83)
      ..close();

    canvas.drawPath(arriba, pintura);
    canvas.drawPath(abajo, pintura);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

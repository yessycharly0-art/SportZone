import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: _FormaPainter(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              children: [
                // Espacio reservado para la imagen de los artículos deportivos.
                // TODO: reemplazar por Image.asset('img/onboarding.png')
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.sports_basketball,
                      size: 120,
                      color: Colors.white24,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Más deportes,',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'más para ti',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.naranja,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AuthScreen()),
                    ),
                    child: const Text('Comenzar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final forma = Path()
      ..moveTo(w * 0.62, h * 0.12)
      ..lineTo(w, h * 0.20)
      ..lineTo(w, h * 0.58)
      ..lineTo(w * 0.02, h * 0.66)
      ..lineTo(w * 0.02, h * 0.42)
      ..close();
    canvas.drawPath(forma, Paint()..color = AppColors.naranja);

    final linea = Paint()
      ..color = AppColors.naranja
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(w, h * 0.68), Offset(0, h * 0.76), linea);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

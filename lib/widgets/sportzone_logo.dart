import 'package:flutter/material.dart';

import '../core/app_theme.dart';

/// Logo provisional hecho con texto e icono.
/// Cuando tengas la imagen real: Image.asset('img/logo.png').
class SportZoneLogo extends StatelessWidget {
  final bool pequeno;
  const SportZoneLogo({super.key, this.pequeno = false});

  @override
  Widget build(BuildContext context) {
    final tamanoTexto = pequeno ? 22.0 : 38.0;
    final texto = RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: tamanoTexto,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),
        children: const [
          TextSpan(text: 'Sport'),
          TextSpan(text: 'Zone', style: TextStyle(color: AppColors.naranja)),
        ],
      ),
    );
    if (pequeno) return texto;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.bolt, size: 56, color: AppColors.naranja),
        texto,
      ],
    );
  }
}

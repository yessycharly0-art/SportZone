import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../models/sesion.dart';
import '../providers/cart_provider.dart';
import 'onboarding_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<CartProvider>().totalFavoritos;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.superficie,
                border: Border.all(color: AppColors.naranja, width: 2),
              ),
              // TODO: foto de perfil con Image.asset / NetworkImage
              child: const Icon(
                Icons.person_outline,
                size: 44,
                color: AppColors.naranja,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              Sesion.nombre,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              Sesion.correo,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textoSecundario,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: _Estadistica(valor: '12', etiqueta: 'Pedidos'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _Estadistica(valor: '$favoritos', etiqueta: 'Favoritos'),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: _Estadistica(valor: '340', etiqueta: 'Puntos'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: AppColors.superficie,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              children: [
                _OpcionPerfil(texto: 'Mis pedidos'),
                _OpcionPerfil(texto: 'Direcciones de envío'),
                _OpcionPerfil(texto: 'Métodos de pago'),
                _OpcionPerfil(texto: 'Ayuda y soporte', ultima: true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () async {
              final cerrarSesion = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: AppColors.superficie,
                  title: const Text('Cerrar sesión'),
                  content: const Text('¿Quieres salir de tu cuenta?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );
              if (cerrarSesion != true || !context.mounted) return;
              context.read<CartProvider>().limpiarSesion();
              Sesion.cerrar();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.naranja,
              side: const BorderSide(color: AppColors.naranja),
              minimumSize: const Size.fromHeight(46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _Estadistica extends StatelessWidget {
  final String valor;
  final String etiqueta;
  const _Estadistica({required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            valor,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.naranja,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textoSecundario,
            ),
          ),
        ],
      ),
    );
  }
}

class _OpcionPerfil extends StatelessWidget {
  final String texto;
  final bool ultima;
  const _OpcionPerfil({required this.texto, this.ultima = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: ListTile(
            dense: true,
            title: Text(texto, style: const TextStyle(fontSize: 13)),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              // TODO: navegar a la pantalla correspondiente
            },
          ),
        ),
        if (!ultima) const Divider(height: 1, color: Colors.white10),
      ],
    );
  }
}

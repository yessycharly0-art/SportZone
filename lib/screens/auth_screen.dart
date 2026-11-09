import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/sesion.dart';
import 'main_shell.dart';

/// Sirve para "Iniciar sesión" y "Registro" (parámetro esRegistro).
class AuthScreen extends StatefulWidget {
  final bool esRegistro;
  const AuthScreen({super.key, this.esRegistro = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _correoCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  bool _ocultar = true;
  String? _error;

  @override
  void dispose() {
    _correoCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    final correo = _correoCtrl.text.trim();
    final pass = _passCtrl.text;
    if (correo.isEmpty || pass.isEmpty) {
      setState(() => _error = 'Escribe tu correo y contraseña');
      return;
    }
    if (!correo.contains('@')) {
      setState(() => _error = 'El correo no es válido');
      return;
    }
    if (widget.esRegistro && pass.length < 6) {
      setState(() => _error = 'La contraseña debe tener mínimo 6 caracteres');
      return;
    }
    // TODO: aquí se conecta Firebase Auth (registrar / iniciarSesion).
    Sesion.correo = correo;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  void _cambiarModo() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AuthScreen(esRegistro: !widget.esRegistro),
      ),
    );
  }

  void _proximamente(String metodo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Inicio con $metodo disponible próximamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registro = widget.esRegistro;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 28),
              const Text('Email', style: _estiloEtiqueta),
              const SizedBox(height: 8),
              TextField(
                controller: _correoCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'email@example.com'),
              ),
              const SizedBox(height: 20),
              const Text('Contraseña', style: _estiloEtiqueta),
              const SizedBox(height: 8),
              TextField(
                controller: _passCtrl,
                obscureText: _ocultar,
                decoration: InputDecoration(
                  hintText: '••••••••••',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultar ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.white70,
                    ),
                    onPressed: () => setState(() => _ocultar = !_ocultar),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              if (!registro)
                GestureDetector(
                  onTap: () {
                    // TODO: recuperar contraseña (sendPasswordResetEmail)
                  },
                  child: const Text(
                    'Olvidé contraseña',
                    style: TextStyle(fontSize: 11, color: AppColors.naranja),
                  ),
                ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: Colors.redAccent)),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _enviar,
                child: Text(registro ? 'Crear cuenta' : 'Iniciar Sesión'),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      registro ? '¿Ya tienes cuenta? ' : 'No tienes cuenta? ',
                      style: const TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: _cambiarModo,
                      child: Text(
                        registro ? 'Inicia sesión' : 'Regístrate',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _BotonSocial(
                texto: 'Inicia con Google',
                icono: Icons.g_mobiledata,
                onPressed: () => _proximamente('Google'),
              ),
              const SizedBox(height: 12),
              _BotonSocial(
                texto: 'Inicia con Apple',
                icono: Icons.apple,
                onPressed: () => _proximamente('Apple'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

const TextStyle _estiloEtiqueta = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.bold,
);

class _BotonSocial extends StatelessWidget {
  final String texto;
  final IconData icono;
  final VoidCallback onPressed;
  const _BotonSocial({
    required this.texto,
    required this.icono,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, size: 22),
      label: Text(texto),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        minimumSize: const Size.fromHeight(40),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        side: const BorderSide(color: AppColors.naranja),
      ),
    );
  }
}

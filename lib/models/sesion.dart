/// Datos simples del usuario en memoria.
/// Cuando conectes Firebase, sustituye esto por FirebaseAuth.instance.currentUser.
class Sesion {
  static String correo = 'usuario@example.com';

  static String get nombre {
    final parte = correo.split('@').first;
    if (parte.isEmpty) return 'Usuario';
    return parte[0].toUpperCase() + parte.substring(1);
  }

  static void cerrar() {
    correo = '';
  }
}

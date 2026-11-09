/// Convierte 1299 en "$1,299".
String formatearPrecio(int valor) {
  final s = valor.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
    buffer.write(s[i]);
  }
  return '\$${buffer.toString()}';
}

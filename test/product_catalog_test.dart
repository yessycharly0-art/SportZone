import 'package:flutter_test/flutter_test.dart';
import 'package:sportzone_lib/models/product.dart';
import 'package:sportzone_lib/providers/cart_provider.dart';

void main() {
  test('cada deporte tiene un catálogo variado', () {
    for (final categoria in categorias) {
      expect(
        productos.where((producto) => producto.categoria == categoria).length,
        greaterThanOrEqualTo(7),
        reason: 'Faltan productos en $categoria',
      );
    }

    expect(
      productos.any((producto) => producto.nombre.contains('Guantes')),
      isTrue,
    );
    expect(
      productos.any((producto) => producto.nombre.contains('Jersey')),
      isTrue,
    );
    expect(
      productos.any((producto) => producto.nombre.contains('Pelotas de Tenis')),
      isTrue,
    );
  });

  test('el carrito distingue las tallas de un mismo producto', () {
    final carrito = CartProvider();
    final jersey = productos.firstWhere(
      (producto) => producto.nombre == 'Jersey Deportivo',
    );

    carrito.agregar(jersey, talla: 'S');
    carrito.agregar(jersey, talla: 'M');

    expect(carrito.items, hasLength(2));
    expect(carrito.totalArticulos, 2);
  });

  test('el producto se puede serializar para Firestore', () {
    final producto = productos.firstWhere((producto) => producto.id == 'p2');
    final reconstruido = Product.fromMap(producto.toMap(), id: producto.id);

    expect(reconstruido.id, producto.id);
    expect(reconstruido.nombre, producto.nombre);
    expect(reconstruido.categoria, producto.categoria);
    expect(reconstruido.precio, producto.precio);
    expect(reconstruido.tallas, producto.tallas);
  });

  test('rechaza datos de producto incompletos', () {
    expect(
      () => Product.fromMap({'nombre': 'Producto'}, id: 'invalido'),
      throwsFormatException,
    );
  });

  test('limpiar sesión elimina carrito y favoritos', () {
    final carrito = CartProvider();
    final producto = productos.first;
    carrito.agregar(producto);
    carrito.alternarFavorito(producto.id);

    carrito.limpiarSesion();

    expect(carrito.totalArticulos, 0);
    expect(carrito.totalFavoritos, 0);
  });
}

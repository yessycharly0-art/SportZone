import 'package:flutter/material.dart';

import '../models/product.dart';

class CartItem {
  final Product producto;
  final String? talla;
  int cantidad;

  CartItem({required this.producto, this.talla, this.cantidad = 1});

  String get clave => '${producto.id}-${talla ?? 'unica'}';
  int get total => producto.precio * cantidad;
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final Set<String> _favoritos = {};

  // ---- Carrito ----
  List<CartItem> get items => _items.values.toList();
  int get totalArticulos =>
      _items.values.fold(0, (suma, item) => suma + item.cantidad);
  int get subtotal => _items.values.fold(0, (suma, item) => suma + item.total);
  int get envio => 0; // envío gratis
  int get total => subtotal + envio;

  void agregar(Product producto, {int cantidad = 1, String? talla}) {
    final nuevo = CartItem(
      producto: producto,
      talla: talla,
      cantidad: cantidad,
    );
    final existente = _items[nuevo.clave];
    if (existente != null) {
      existente.cantidad += cantidad;
    } else {
      _items[nuevo.clave] = nuevo;
    }
    notifyListeners();
  }

  void cambiarCantidad(String clave, int delta) {
    final item = _items[clave];
    if (item == null) return;
    item.cantidad += delta;
    if (item.cantidad <= 0) _items.remove(clave);
    notifyListeners();
  }

  void vaciar() {
    _items.clear();
    notifyListeners();
  }

  void limpiarSesion() {
    _items.clear();
    _favoritos.clear();
    notifyListeners();
  }

  // ---- Favoritos ----
  int get totalFavoritos => _favoritos.length;
  bool esFavorito(String id) => _favoritos.contains(id);

  void alternarFavorito(String id) {
    if (!_favoritos.remove(id)) _favoritos.add(id);
    notifyListeners();
  }
}

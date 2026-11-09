import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_grid.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CartProvider>();
    final lista = productos.where((p) => carrito.esFavorito(p.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: lista.isEmpty
          ? const Center(
              child: Text(
                'Aún no tienes favoritos',
                style: TextStyle(color: AppColors.textoSecundario),
              ),
            )
          : ProductGrid(lista: lista),
    );
  }
}

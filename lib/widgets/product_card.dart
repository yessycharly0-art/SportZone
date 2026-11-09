import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../core/formato.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product producto;
  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(producto: producto),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.superficie,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.superficieClara,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: producto.imagenUrl == null || producto.imagenUrl!.isEmpty
                    ? Icon(producto.icono, size: 48, color: Colors.white)
                    : Image.network(
                        producto.imagenUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) =>
                            Icon(producto.icono, size: 48, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              producto.nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              producto.categoria,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textoSecundario,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatearPrecio(producto.precio),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.naranja,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<CartProvider>().agregar(
                      producto,
                      talla: producto.tallas.isNotEmpty
                          ? producto.tallas[producto.tallas.length ~/ 2]
                          : null,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${producto.nombre} agregado al carrito'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.naranja,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

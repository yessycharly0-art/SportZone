import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../core/formato.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product producto;
  const ProductDetailScreen({super.key, required this.producto});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _cantidad = 1;
  String? _talla;

  @override
  void initState() {
    super.initState();
    final tallas = widget.producto.tallas;
    if (tallas.isNotEmpty) _talla = tallas[tallas.length ~/ 2];
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.producto;
    final esFavorito = context.watch<CartProvider>().esFavorito(p.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: Icon(
              esFavorito ? Icons.favorite : Icons.favorite_border,
              color: esFavorito ? Colors.redAccent : Colors.white,
            ),
            onPressed: () =>
                context.read<CartProvider>().alternarFavorito(p.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.superficieClara,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    color: AppColors.marron,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: p.imagenUrl == null || p.imagenUrl!.isEmpty
                        ? Icon(p.icono, size: 90, color: Colors.white)
                        : Image.network(
                            p.imagenUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                Icon(p.icono, size: 90, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              p.categoria.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: AppColors.naranja,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    p.nombre,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  formatearPrecio(p.precio),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.naranja,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: AppColors.naranja),
                const SizedBox(width: 4),
                Text(
                  '${p.rating}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '  (${p.resenas} reseñas)',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textoSecundario,
                  ),
                ),
              ],
            ),
            if (p.tallas.isNotEmpty) ...[
              const SizedBox(height: 18),
              const Text(
                'Tallas',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  for (final t in p.tallas)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => setState(() => _talla = t),
                        child: Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _talla == t
                                ? AppColors.naranja
                                : AppColors.superficie,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _talla == t ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 18),
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              p.descripcion,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: AppColors.textoSecundario,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: AppColors.superficie,
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: _cantidad > 1
                    ? () => setState(() => _cantidad--)
                    : null,
              ),
              Text(
                '$_cantidad',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () => setState(() => _cantidad++),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartProvider>().agregar(
                      p,
                      cantidad: _cantidad,
                      talla: _talla,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${p.nombre} agregado al carrito'),
                      ),
                    );
                  },
                  child: const Text('Agregar al carrito'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

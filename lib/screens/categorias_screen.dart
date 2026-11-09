import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Encuentra lo que necesitas para tu próximo entrenamiento.',
                style: TextStyle(color: AppColors.textoSecundario),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final categoria = categorias[index];
                final cantidad = productos
                    .where((producto) => producto.categoria == categoria)
                    .length;
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _CategoriaProductos(categoria: categoria),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.superficie,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconoCategoria[categoria],
                          size: 44,
                          color: AppColors.naranja,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          categoria,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$cantidad productos',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textoSecundario,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: categorias.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriaProductos extends StatelessWidget {
  final String categoria;
  const _CategoriaProductos({required this.categoria});

  @override
  Widget build(BuildContext context) {
    final lista = productos.where((p) => p.categoria == categoria).toList();
    return Scaffold(
      appBar: AppBar(title: Text('$categoria (${lista.length})')),
      body: lista.isEmpty
          ? const Center(
              child: Text(
                'Pronto habrá productos en esta categoría.',
                style: TextStyle(color: AppColors.textoSecundario),
              ),
            )
          : ProductGrid(lista: lista),
    );
  }
}

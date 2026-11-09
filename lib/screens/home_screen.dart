import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/sportzone_logo.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _busquedaController = TextEditingController();
  String _categoria = 'Todos';
  String _busqueda = '';

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lista = productos.where((p) {
      final okCategoria = _categoria == 'Todos' || p.categoria == _categoria;
      final consulta = _busqueda.trim().toLowerCase();
      final okBusqueda =
          consulta.isEmpty ||
          p.nombre.toLowerCase().contains(consulta) ||
          p.categoria.toLowerCase().contains(consulta) ||
          p.descripcion.toLowerCase().contains(consulta);
      return okCategoria && okBusqueda;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.naranja),
          onPressed: () {
            // TODO: abrir menú lateral (Drawer)
          },
        ),
        title: const SportZoneLogo(pequeno: true),
        actions: [
          Consumer<CartProvider>(
            builder: (context, carrito, _) => IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              icon: Badge(
                isLabelVisible: carrito.totalArticulos > 0,
                label: Text('${carrito.totalArticulos}'),
                child: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.naranja,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _busquedaController,
              onChanged: (t) => setState(() => _busqueda = t),
              decoration: InputDecoration(
                hintText: 'Buscar productos, categorías...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _busqueda.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpiar búsqueda',
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: _busquedaController.clear,
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categorías',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final c in ['Todos', ...categorias])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: _categoria == c,
                      showCheckmark: false,
                      selectedColor: AppColors.naranja,
                      backgroundColor: AppColors.superficie,
                      side: BorderSide.none,
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _categoria == c ? Colors.black : Colors.white,
                      ),
                      onSelected: (_) => setState(() => _categoria = c),
                    ),
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Destacados',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ver todo',
                  style: TextStyle(fontSize: 11, color: AppColors.naranja),
                ),
              ],
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron productos',
                      style: TextStyle(color: AppColors.textoSecundario),
                    ),
                  )
                : ProductGrid(lista: lista),
          ),
        ],
      ),
    );
  }
}

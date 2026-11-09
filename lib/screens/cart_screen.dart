import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../core/formato.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CartProvider>();
    final items = carrito.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi carrito'),
        leading: const BackButton(),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Tu carrito está vacío',
                style: TextStyle(color: AppColors.textoSecundario),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final item in items) _ItemCarrito(item: item),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.superficie,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      _FilaResumen(
                        etiqueta: 'Subtotal',
                        valor: formatearPrecio(carrito.subtotal),
                      ),
                      const SizedBox(height: 8),
                      _FilaResumen(
                        etiqueta: 'Envío',
                        valor: carrito.envio == 0
                            ? 'Gratis'
                            : formatearPrecio(carrito.envio),
                        colorValor: AppColors.naranja,
                      ),
                      const Divider(height: 24, color: Colors.white12),
                      _FilaResumen(
                        etiqueta: 'Total',
                        valor: formatearPrecio(carrito.total),
                        grande: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SafeArea(
                top: false,
                child: ElevatedButton(
                  onPressed: () => _finalizarCompra(context),
                  child: const Text('Finalizar compra'),
                ),
              ),
            ),
    );
  }

  void _finalizarCompra(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.superficie,
        title: const Text('¡Compra realizada!'),
        content: const Text('Gracias por tu compra en SportZone.'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartProvider>().vaciar();
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}

class _ItemCarrito extends StatelessWidget {
  final CartItem item;
  const _ItemCarrito({required this.item});

  @override
  Widget build(BuildContext context) {
    final carrito = context.read<CartProvider>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.superficieClara,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                item.producto.imagenUrl == null ||
                    item.producto.imagenUrl!.isEmpty
                ? Icon(item.producto.icono, color: Colors.white)
                : Image.network(
                    item.producto.imagenUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) =>
                        Icon(item.producto.icono, color: Colors.white),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.producto.nombre,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item.talla != null
                      ? 'Talla ${item.talla}'
                      : item.producto.categoria,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textoSecundario,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatearPrecio(item.producto.precio),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.naranja,
                  ),
                ),
              ],
            ),
          ),
          _BotonCantidad(
            icono: Icons.remove,
            onTap: () => carrito.cambiarCantidad(item.clave, -1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${item.cantidad}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          _BotonCantidad(
            icono: Icons.add,
            onTap: () => carrito.cambiarCantidad(item.clave, 1),
          ),
        ],
      ),
    );
  }
}

class _BotonCantidad extends StatelessWidget {
  final IconData icono;
  final VoidCallback onTap;
  const _BotonCantidad({required this.icono, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.superficieClara,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icono, size: 14),
      ),
    );
  }
}

class _FilaResumen extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final bool grande;
  final Color? colorValor;
  const _FilaResumen({
    required this.etiqueta,
    required this.valor,
    this.grande = false,
    this.colorValor,
  });

  @override
  Widget build(BuildContext context) {
    final tamano = grande ? 18.0 : 13.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          etiqueta,
          style: TextStyle(
            fontSize: tamano,
            fontWeight: grande ? FontWeight.bold : FontWeight.normal,
            color: grande ? Colors.white : AppColors.textoSecundario,
          ),
        ),
        Text(
          valor,
          style: TextStyle(
            fontSize: tamano,
            fontWeight: FontWeight.bold,
            color: grande ? AppColors.naranja : (colorValor ?? Colors.white),
          ),
        ),
      ],
    );
  }
}

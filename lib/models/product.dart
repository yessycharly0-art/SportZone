import 'package:flutter/material.dart';

class Product {
  final String id;
  final String nombre;
  final String categoria;
  final int precio;
  final String descripcion;
  final double rating;
  final int resenas;
  final List<String> tallas;
  final String? imagenUrl;
  final IconData icono;

  const Product({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.precio,
    required this.descripcion,
    required this.icono,
    this.rating = 4.5,
    this.resenas = 100,
    this.tallas = const [],
    this.imagenUrl,
  });

  factory Product.fromMap(Map<String, dynamic> data, {required String id}) {
    final nombre = data['nombre'];
    final categoria = data['categoria'];
    final precio = data['precio'];
    final descripcion = data['descripcion'];
    final rating = data['rating'];
    final resenas = data['resenas'];
    final tallas = data['tallas'];
    final imagenUrl = data['imagenUrl'];

    if (nombre is! String ||
        categoria is! String ||
        precio is! num ||
        descripcion is! String ||
        (rating != null && rating is! num) ||
        (resenas != null && resenas is! num) ||
        (tallas != null &&
            (tallas is! List || tallas.any((talla) => talla is! String))) ||
        (imagenUrl != null && imagenUrl is! String)) {
      throw FormatException('Los datos del producto "$id" no son válidos.');
    }

    return Product(
      id: id,
      nombre: nombre,
      categoria: categoria,
      precio: precio.toInt(),
      descripcion: descripcion,
      icono: iconoCategoria[categoria] ?? Icons.fitness_center,
      rating: (rating as num?)?.toDouble() ?? 4.5,
      resenas: (resenas as num?)?.toInt() ?? 100,
      tallas: (tallas as List?)?.cast<String>() ?? const [],
      imagenUrl: imagenUrl as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'categoria': categoria,
    'precio': precio,
    'descripcion': descripcion,
    'rating': rating,
    'resenas': resenas,
    'tallas': tallas,
    'imagenUrl': imagenUrl,
  };
}

const List<String> categorias = ['Fútbol', 'Basquet', 'Running', 'Tenis'];

const Map<String, IconData> iconoCategoria = {
  'Fútbol': Icons.sports_soccer,
  'Basquet': Icons.sports_basketball,
  'Running': Icons.directions_run,
  'Tenis': Icons.sports_tennis,
};

const List<Product> productos = [
  Product(
    id: 'p1',
    nombre: 'Balón Clásico',
    categoria: 'Fútbol',
    precio: 499,
    icono: Icons.sports_soccer,
    descripcion: 'Balón de fútbol cosido a máquina, ideal para entrenar y jugar en cancha.',
  ),
  Product(
    id: 'p2',
    nombre: 'Tenis Air Run',
    categoria: 'Running',
    precio: 1299,
    icono: Icons.directions_run,
    rating: 4.5,
    resenas: 126,
    tallas: ['25', '26', '27', '28', '29'],
    descripcion: 'Tenis ligeros con amortiguación reactiva y suela de alto agarre. Ideales para correr en asfalto y pista.',
  ),
  Product(
    id: 'p3',
    nombre: 'Balón Street',
    categoria: 'Basquet',
    precio: 449,
    icono: Icons.sports_basketball,
    descripcion:
        'Balón de basquetbol resistente para cancha exterior, con buen agarre.',
  ),
  Product(
    id: 'p4',
    nombre: 'Raqueta Elite',
    categoria: 'Tenis',
    precio: 1149,
    icono: Icons.sports_tennis,
    descripcion:
        'Raqueta ligera con marco reforzado para mayor control y potencia.',
  ),
  Product(
    id: 'p5',
    nombre: 'Balón Pro',
    categoria: 'Fútbol',
    precio: 998,
    icono: Icons.sports_soccer,
    descripcion:
        'Balón profesional termosellado, con excelente estabilidad de vuelo.',
  ),
  Product(
    id: 'p6',
    nombre: 'Guantes de Portero Grip',
    categoria: 'Fútbol',
    precio: 899,
    icono: Icons.sports_soccer,
    tallas: ['S', 'M', 'L', 'XL'],
    descripcion: 'Guantes con palma de alto agarre, ajuste en la muñeca y protección para entrenamientos y partidos.',
  ),
  Product(
    id: 'p7',
    nombre: 'Jersey Deportivo',
    categoria: 'Fútbol',
    precio: 749,
    icono: Icons.sports_soccer,
    tallas: ['S', 'M', 'L', 'XL'],
    descripcion: 'Jersey ligero y transpirable para jugar fútbol o apoyar a tu equipo favorito.',
  ),
  Product(
    id: 'p8',
    nombre: 'Botines para Césped',
    categoria: 'Fútbol',
    precio: 1599,
    icono: Icons.sports_soccer,
    tallas: ['25', '26', '27', '28', '29'],
    descripcion: 'Botines con tacos resistentes y ajuste cómodo para mejorar la tracción en la cancha.',
  ),
  Product(
    id: 'p9',
    nombre: 'Espinilleras Pro',
    categoria: 'Fútbol',
    precio: 349,
    icono: Icons.sports_soccer,
    descripcion: 'Espinilleras ligeras con cubierta rígida y acolchado interior para protegerte durante el juego.',
  ),
  Product(
    id: 'p10',
    nombre: 'Jersey de Basquetbol',
    categoria: 'Basquet',
    precio: 799,
    icono: Icons.sports_basketball,
    tallas: ['S', 'M', 'L', 'XL'],
    descripcion:
        'Jersey sin mangas, fresco y cómodo para entrenar o jugar basquetbol.',
  ),
  Product(
    id: 'p11',
    nombre: 'Tenis Court',
    categoria: 'Basquet',
    precio: 1699,
    icono: Icons.sports_basketball,
    tallas: ['25', '26', '27', '28', '29'],
    descripcion: 'Tenis con soporte lateral y suela de buen agarre para movimientos rápidos en la duela.',
  ),
  Product(
    id: 'p12',
    nombre: 'Balón de Basquetbol Pro',
    categoria: 'Basquet',
    precio: 599,
    icono: Icons.sports_basketball,
    descripcion: 'Balón con superficie texturizada para un mejor control en canchas interiores y exteriores.',
  ),
  Product(
    id: 'p13',
    nombre: 'Playera Running Dry',
    categoria: 'Running',
    precio: 599,
    icono: Icons.directions_run,
    tallas: ['S', 'M', 'L', 'XL'],
    descripcion: 'Playera ligera de secado rápido para mantenerte cómodo en tus carreras y entrenamientos.',
  ),
  Product(
    id: 'p14',
    nombre: 'Short Deportivo',
    categoria: 'Running',
    precio: 499,
    icono: Icons.directions_run,
    tallas: ['S', 'M', 'L', 'XL'],
    descripcion: 'Short con cintura ajustable y tela flexible para correr con libertad de movimiento.',
  ),
  Product(
    id: 'p15',
    nombre: 'Botella Deportiva',
    categoria: 'Running',
    precio: 249,
    icono: Icons.water_drop,
    descripcion: 'Botella reutilizable y ligera para mantenerte hidratado durante tus entrenamientos.',
  ),
  Product(
    id: 'p16',
    nombre: 'Pelotas de Tenis (3 piezas)',
    categoria: 'Tenis',
    precio: 299,
    icono: Icons.sports_tennis,
    descripcion: 'Paquete de tres pelotas con rebote consistente para prácticas y partidos recreativos.',
  ),
  Product(
    id: 'p17',
    nombre: 'Tenis Match',
    categoria: 'Tenis',
    precio: 1899,
    icono: Icons.sports_tennis,
    tallas: ['25', '26', '27', '28', '29'],
    descripcion: 'Calzado con suela de agarre y soporte para cambios de dirección en la cancha.',
  ),
  Product(
    id: 'p18',
    nombre: 'Overgrip para Raqueta',
    categoria: 'Tenis',
    precio: 129,
    icono: Icons.sports_tennis,
    descripcion: 'Cinta antideslizante que mejora el agarre de tu raqueta y absorbe la humedad.',
  ),
  Product(
    id: 'p19',
    nombre: 'Mochila Deportiva',
    categoria: 'Fútbol',
    precio: 899,
    icono: Icons.backpack,
    descripcion: 'Mochila amplia con compartimento ventilado para calzado y bolsillos para tus accesorios.',
  ),
  Product(
    id: 'p20',
    nombre: 'Conos de Entrenamiento',
    categoria: 'Fútbol',
    precio: 199,
    icono: Icons.sports,
    descripcion: 'Set de conos flexibles para ejercicios de velocidad, coordinación y control de balón.',
  ),
  Product(
    id: 'p21',
    nombre: 'Tobilleras Deportivas',
    categoria: 'Fútbol',
    precio: 289,
    icono: Icons.sports,
    descripcion: 'Soporte ligero y transpirable para dar estabilidad durante tus entrenamientos.',
  ),
  Product(
    id: 'p22',
    nombre: 'Aro de Basquetbol',
    categoria: 'Basquet',
    precio: 1199,
    icono: Icons.sports_basketball,
    descripcion: 'Aro resistente para practicar tiros y mejorar tu juego en casa o en la cancha.',
  ),
  Product(
    id: 'p23',
    nombre: 'Muñequeras (Par)',
    categoria: 'Basquet',
    precio: 179,
    icono: Icons.sports_basketball,
    descripcion: 'Muñequeras absorbentes y cómodas para mantener tus manos secas durante el partido.',
  ),
  Product(
    id: 'p24',
    nombre: 'Balón Mini Basquetbol',
    categoria: 'Basquet',
    precio: 329,
    icono: Icons.sports_basketball,
    descripcion: 'Balón ligero de tamaño compacto para practicar dribles y tiros en cualquier lugar.',
  ),
  Product(
    id: 'p25',
    nombre: 'Calcetas para Running',
    categoria: 'Running',
    precio: 199,
    icono: Icons.directions_run,
    tallas: ['S', 'M', 'L'],
    descripcion: 'Calcetas acolchadas con zonas transpirables para mayor comodidad en recorridos largos.',
  ),
  Product(
    id: 'p26',
    nombre: 'Cangurera Reflectante',
    categoria: 'Running',
    precio: 349,
    icono: Icons.directions_run,
    descripcion: 'Lleva tus objetos esenciales con ajuste cómodo y detalles reflectantes para correr de noche.',
  ),
  Product(
    id: 'p27',
    nombre: 'Gorra Running',
    categoria: 'Running',
    precio: 299,
    icono: Icons.directions_run,
    descripcion: 'Gorra ligera de secado rápido que ayuda a protegerte del sol durante tus carreras.',
  ),
  Product(
    id: 'p28',
    nombre: 'Raqueta Control',
    categoria: 'Tenis',
    precio: 1399,
    icono: Icons.sports_tennis,
    descripcion: 'Raqueta equilibrada para jugadores que buscan precisión y comodidad en cada golpe.',
  ),
  Product(
    id: 'p29',
    nombre: 'Mochila para Raquetas',
    categoria: 'Tenis',
    precio: 999,
    icono: Icons.backpack,
    descripcion: 'Mochila con espacio para raquetas, ropa y accesorios para tus partidos.',
  ),
  Product(
    id: 'p30',
    nombre: 'Muñequera para Tenis',
    categoria: 'Tenis',
    precio: 159,
    icono: Icons.sports_tennis,
    descripcion: 'Accesorio suave y absorbente para entrenar y competir con mayor comodidad.',
  ),
];

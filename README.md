# SportZone

Aplicación móvil de compra de artículos deportivos desarrollada con Flutter. Permite explorar un catálogo por deportes, buscar productos, ver su detalle, marcarlos como favoritos y armar un carrito de compras.

Proyecto Final · Aplicaciones Móviles con Flutter  
9.º Cuatrimestre · Grupo A · Equipo 5

## Funcionalidades

- **Flujo de entrada:** pantalla de inicio (splash), bienvenida e inicio de sesión / registro con validación de formularios.
- **Catálogo:** 30 productos de 4 deportes: Fútbol, Basquet, Running y Tenis.
- **Búsqueda y categorías** para encontrar artículos rápidamente.
- **Detalle de producto:** descripción, calificación, reseñas y tallas disponibles.
- **Favoritos:** marca y consulta tus productos preferidos.
- **Carrito de compras:** agrega productos por talla, cambia cantidades y consulta subtotal, envío y total.
- **Perfil de usuario** con opción de cerrar sesión (limpia carrito y favoritos de la sesión).
- **Tema global oscuro** con acento naranja, aplicado a toda la app.

## Tecnologías

- [Flutter](https://flutter.dev) y [Dart](https://dart.dev): desarrollo de la app con una sola base de código.
- [Provider](https://pub.dev/packages/provider): estado compartido (carrito y favoritos).
- [Firebase](https://firebase.google.com): inicializado y listo para integrar servicios en la Etapa 2.
- Git y GitHub: control de versiones y trabajo en equipo.
- Visual Studio Code: entorno de desarrollo.

## Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart `>=3.13.0 <4.0.0`)
- Chrome o Edge para ejecutar en web, o un emulador / dispositivo Android
- VS Code con las extensiones de **Flutter** y **Dart**

Puedes verificar tu instalación con:

flutter doctor

## Instalación y ejecución

# 1. Clona el repositorio
git clone https://github.com/yessycharly0-art/SportZone.git
cd SportZone

# 2. Instala las dependencias
flutter pub get

# 3. Ejecuta la app (elige uno)
flutter run -d chrome     # navegador
flutter run               # dispositivo o emulador conectado

Para correr las pruebas:

'flutter test'


> **Nota:** si tras clonar aparecen errores de compilación, prueba 'flutter clean' y luego 'flutter pub get'.

## Pantallas

Flujo de navegación:

**Splash → Bienvenida → Inicio de sesión / Registro → Pantalla principal → Detalle → Carrito**

La pantalla principal incluye una barra de navegación inferior con cuatro secciones:

- Inicio: búsqueda y listado de productos.
- Categorías: productos organizados por deporte.
- Favoritos: productos marcados por el usuario.
- Perfil: datos del usuario y cierre de sesión.

## Arquitectura

La app separa el modelo de datos, el estado y la interfaz:

- **Model:** clases de datos (`Product`, `Sesion`).
- **Provider:** `CartProvider` expone el carrito y los favoritos a la interfaz y notifica los cambios.
- **Screens y widgets:** interfaz de usuario con componentes reutilizables (`ProductCard`, `ProductGrid`, `SportZoneLogo`).

## Estructura del proyecto

lib/
├── core/         # Tema global (app_theme) y utilidades de formato
├── models/       # Product y Sesion
├── providers/    # CartProvider (carrito y favoritos)
├── screens/      # Splash, onboarding, auth, inicio, categorías,
│                 # favoritos, perfil, detalle, carrito y main_shell
├── widgets/      # ProductCard, ProductGrid, SportZoneLogo
└── main.dart     # Punto de entrada
test/
├── product_catalog_test.dart
└── widget_test.dart


## Estado de los datos y Firebase

En la **Etapa 1** los datos son locales:

- El catálogo es una lista fija en `lib/models/product.dart`.
- La autenticación es una **simulación local**; todavía no existe una cuenta remota.

Firebase ya está inicializado en `main()`. El modelo `Product` incluye `toMap()` y `Product.fromMap(...)` para guardar y leer documentos de Firestore. Una colección `productos` usaría documentos con esta forma:

json
{
  "nombre": "Tenis Air Run",
  "categoria": "Running",
  "precio": 1299,
  "descripcion": "Tenis ligeros para correr.",
  "rating": 4.5,
  "resenas": 126,
  "tallas": ["25", "26", "27"],
  "imagenUrl": "https://..."
}

## Identidad visual

Fondo oscuro con acento naranja para transmitir energía y movimiento.

- Fondo: '#1A1C21'
- Superficie: '#262932'
- Naranja (acento): '#E8964A'
- Marrón: '#7A5232'

## Autores

- Carlos López Peña – _[223112082-lang]_()
- Diego Ian León Contreras – [@leondiego904](https://github.com/leondiego904)
- Yessenia Martínez Jiménez – [@yessycharly0-art](https://github.com/yessycharly0-art)

Docente: Mario A. Gea Pérez

## Licencia

Proyecto académico con fines educativos.

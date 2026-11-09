# 🏃 SportZone

Aplicación móvil de compra de artículos deportivos desarrollada con **Flutter**. Permite explorar un catálogo por deportes, buscar productos, ver su detalle, marcarlos como favoritos y armar un carrito de compras.

Proyecto Final · **Etapa 1** · Aplicaciones Móviles con Flutter  
9.º Cuatrimestre · Grupo A · Equipo 5

## 📸 Capturas

<!-- Cuando tengas las capturas, crea la carpeta `screenshots/`, guarda ahí tus
     imágenes y quita estas marcas de comentario (<!-- y -->) para mostrarlas.

| Splash | Bienvenida | Inicio | Detalle | Carrito |
|--------|------------|--------|---------|---------|
| ![Splash](screenshots/splash.png) | ![Bienvenida](screenshots/bienvenida.png) | ![Inicio](screenshots/inicio.png) | ![Detalle](screenshots/detalle.png) | ![Carrito](screenshots/carrito.png) |
-->

_Próximamente._

## ✨ Funcionalidades

- **Flujo de entrada:** pantalla de inicio (splash), bienvenida e inicio de sesión / registro con validación de formularios.
- **Catálogo:** 30 productos de 4 deportes: Fútbol, Basquet, Running y Tenis.
- **Búsqueda y categorías** para encontrar artículos rápidamente.
- **Detalle de producto:** descripción, calificación, reseñas y tallas disponibles.
- **Favoritos:** marca y consulta tus productos preferidos.
- **Carrito de compras:** agrega productos por talla, cambia cantidades y consulta subtotal, envío y total.
- **Perfil de usuario** con opción de cerrar sesión (limpia carrito y favoritos de la sesión).
- **Tema global oscuro** con acento naranja, aplicado a toda la app.

## 🛠️ Tecnologías

| Tecnología | Uso |
|------------|-----|
| [Flutter](https://flutter.dev) / [Dart](https://dart.dev) | Desarrollo de la app con una sola base de código |
| [Provider](https://pub.dev/packages/provider) | Estado compartido (carrito y favoritos) |
| [Firebase](https://firebase.google.com) | Inicializado y listo para integrar servicios en la Etapa 2 |
| Git y GitHub | Control de versiones y trabajo en equipo |
| Visual Studio Code | Entorno de desarrollo |

## 📋 Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart `>=3.13.0 <4.0.0`)
- Chrome o Edge para ejecutar en web, o un emulador / dispositivo Android
- VS Code con las extensiones de **Flutter** y **Dart**

Puedes verificar tu instalación con:

```bash
flutter doctor
```

## 🚀 Instalación y ejecución

```bash
# 1. Clona el repositorio
git clone https://github.com/yessycharly0-art/SportZone.git
cd SportZone

# 2. Instala las dependencias
flutter pub get

# 3. Ejecuta la app (elige uno)
flutter run -d chrome     # navegador
flutter run               # dispositivo o emulador conectado
```

Para correr las pruebas:

```bash
flutter test
```

> **Nota:** si tras clonar aparecen errores de compilación, prueba `flutter clean` y luego `flutter pub get`.

## 📱 Pantallas

Flujo de navegación:

**Splash → Bienvenida → Inicio de sesión / Registro → Pantalla principal → Detalle → Carrito**

La pantalla principal incluye una barra de navegación inferior con cuatro secciones:

| Sección | Descripción |
|---------|-------------|
| Inicio | Búsqueda y listado de productos |
| Categorías | Productos organizados por deporte |
| Favoritos | Productos marcados por el usuario |
| Perfil | Datos del usuario y cierre de sesión |

## 🏗️ Arquitectura

La app separa el modelo de datos, el estado y la interfaz:

- **Model:** clases de datos (`Product`, `Sesion`).
- **Provider:** `CartProvider` expone el carrito y los favoritos a la interfaz y notifica los cambios.
- **Screens y widgets:** interfaz de usuario con componentes reutilizables (`ProductCard`, `ProductGrid`, `SportZoneLogo`).

## 📁 Estructura del proyecto

```
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
```

## 🔥 Estado de los datos y Firebase

En la **Etapa 1** los datos son locales:

- El catálogo es una lista fija en `lib/models/product.dart`.
- La autenticación es una **simulación local**; todavía no existe una cuenta remota.

Firebase ya está inicializado en `main()`. El modelo `Product` incluye `toMap()` y `Product.fromMap(...)` para guardar y leer documentos de Firestore. Una colección `productos` usaría documentos con esta forma:

```json
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
```

Si quieres usar tu propio proyecto de Firebase:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

> **Seguridad:** no subas claves privadas ni cuentas de servicio al repositorio, y configura las reglas de Firestore y Authentication antes de publicar la app.

## 🗺️ Siguientes pasos (Etapa 2)

- [ ] Firebase Authentication para inicio de sesión y registro reales
- [ ] Migrar el catálogo a Cloud Firestore
- [ ] Guardar el carrito y el historial de compras por usuario
- [ ] Favoritos sincronizados con la cuenta
- [ ] Generar el APK y probar con usuarios
- [ ] Pasarela de pago, reseñas y notificaciones de ofertas

## 🎨 Identidad visual

Fondo oscuro con acento naranja para transmitir energía y movimiento.

| Color | Hex |
|-------|-----|
| Fondo | `#1A1C21` |
| Superficie | `#262932` |
| Naranja (acento) | `#E8964A` |
| Marrón | `#7A5232` |

## 🤖 Uso de inteligencia artificial y fuentes externas

El uso de herramientas de IA durante el desarrollo se documenta en [`AI_LOG.md`](AI_LOG.md). El código tomado de tutoriales, repositorios o foros se cita en esta sección.

- _[Agregar aquí las fuentes externas utilizadas, si las hay]_

## 👥 Autores

| Integrante | GitHub |
|------------|--------|
| Carlos López Peña | _[agregar usuario]_ |
| Diego Ian León Contreras | [@leondiego904](https://github.com/leondiego904) |
| Yessenia Martínez Jiménez | [@yessycharly0-art](https://github.com/yessycharly0-art) |

**Docente:** Mario A. Gea Pérez

## 📄 Licencia

Proyecto académico con fines educativos.

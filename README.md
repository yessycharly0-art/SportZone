# SportZone

Aplicación Flutter de tienda deportiva con catálogo de ejemplo, búsqueda,
categorías, favoritos, carrito y perfil.

## Ejecutar

```sh
flutter pub get
flutter run
```

La autenticación actual es una simulación local. El cierre de sesión limpia el
carrito y los favoritos de la sesión, pero todavía no cierra una cuenta remota.

## Preparación para Firebase

El modelo `Product` incluye `toMap()` y `Product.fromMap(...)` para guardar y
leer documentos de Firestore. El identificador se conserva como ID del
documento, y `imagenUrl` permite mostrar imágenes alojadas en Firebase Storage
u otro servicio compatible.

Una colección `productos` puede usar documentos con esta forma:

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

Para conectar un proyecto Firebase real:

1. Crea o selecciona el proyecto en Firebase y habilita Authentication
   (correo/contraseña) y Cloud Firestore.
2. Instala y ejecuta FlutterFire CLI: `dart pub global activate flutterfire_cli`
   y luego `flutterfire configure`.
3. Agrega los paquetes oficiales `firebase_core`, `firebase_auth` y
   `cloud_firestore` con `flutter pub add`.
4. Inicializa Firebase en `main()` usando las opciones generadas por
   FlutterFire antes de `runApp`.
5. Sustituye la validación local de `AuthScreen` por `FirebaseAuth` y carga la
   colección `productos` con `Product.fromMap(doc.data(), id: doc.id)`.
   Para salir, utiliza `FirebaseAuth.instance.signOut()`.
6. Configura reglas de Firestore y Firebase Storage para tu aplicación antes
   de publicar. No guardes credenciales ni claves de servicio en el código.

La inicialización y las credenciales de Firebase no se incluyen porque dependen
del proyecto y las plataformas que se vayan a habilitar.

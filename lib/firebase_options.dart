// Opciones de Firebase por plataforma.
//
// ⚠️ Las claves NO se escriben aquí: se inyectan al compilar/ejecutar con
//   flutter run --dart-define-from-file=dart_define.json
// (igual que el token de TMDB). El archivo `dart_define.json` está ignorado por
// Git, así que este repositorio público no expone ninguna clave.
//
// Las claves de Firebase del lado cliente no son "secretas" (viajan en toda app
// web/Android), pero las mantenemos fuera del código por preferencia. La
// seguridad real la dan las reglas de Firestore (ver firestore.rules) y, si se
// desea, restringir la API key por dominio/paquete en Google Cloud Console.
//
// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Opciones por plataforma para inicializar Firebase.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'iOS aún no está configurado. Registra la app iOS en Firebase y '
          'agrega aquí sus opciones.',
        );
      default:
        throw UnsupportedError(
          'FirebaseOptions no configuradas para esta plataforma.',
        );
    }
  }

  // Valores compartidos entre plataformas (inyectados por --dart-define).
  static const _projectId = String.fromEnvironment('FB_PROJECT_ID');
  static const _messagingSenderId =
      String.fromEnvironment('FB_MESSAGING_SENDER_ID');
  static const _storageBucket = String.fromEnvironment('FB_STORAGE_BUCKET');

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: String.fromEnvironment('FB_WEB_API_KEY'),
    appId: String.fromEnvironment('FB_WEB_APP_ID'),
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    authDomain: String.fromEnvironment('FB_AUTH_DOMAIN'),
    storageBucket: _storageBucket,
    measurementId: String.fromEnvironment('FB_WEB_MEASUREMENT_ID'),
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment('FB_ANDROID_API_KEY'),
    appId: String.fromEnvironment('FB_ANDROID_APP_ID'),
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    storageBucket: _storageBucket,
  );
}

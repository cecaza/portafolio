/// Configuración de la API de TheMovieDB (TMDB).
///
/// ─────────────────────────────────────────────────────────────────────────
/// Autenticación: usamos el "API Read Access Token" (v4, tipo Bearer) que se
/// obtiene en https://www.themoviedb.org/settings/api y se envía en el header
/// `Authorization: Bearer <token>`.
///
/// ⚠️ El token NO se escribe aquí. Se inyecta al compilar/ejecutar para que no
/// quede en el código fuente. Se lee con `String.fromEnvironment`:
///
///   flutter run --dart-define-from-file=dart_define.json
///
/// El archivo `dart_define.json` está ignorado por Git (ver .gitignore) y
/// contiene: { "TMDB_ACCESS_TOKEN": "<tu token>" }.
/// En VSCode el botón ▶️ (Run) ya lo usa automáticamente (.vscode/launch.json).
/// ─────────────────────────────────────────────────────────────────────────
class Constants {
  Constants._();

  /// API Read Access Token (v4) de TheMovieDB, inyectado por --dart-define.
  static const String accessToken =
      String.fromEnvironment('TMDB_ACCESS_TOKEN');

  /// Base de la API de TheMovieDB.
  static const String baseUrl = 'api.themoviedb.org';

  /// Prefijo de versión de la API.
  static const String apiVersion = '/3';

  /// Base para construir URLs de imágenes (avatares, posters, etc.).
  static const String imagesBaseUrl = 'https://image.tmdb.org/t/p/w500';

  /// Clave del session_id guardado en el almacenamiento seguro.
  static const String sessionKey = 'sessionId';
}

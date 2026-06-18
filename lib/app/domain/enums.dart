/// Posibles fallos al iniciar sesión contra la API de TheMovieDB.
enum SignInFailure {
  notFound,
  unauthorized,
  unknown,
  notVerified,
  network,
  tooManyRequests,
}

/// Resultado de una petición HTTP fallida.
enum HttpFailureType {
  network,
  notFound,
  unauthorized,
  forbidden,
  server,
  local,
  unknown,
}

/// Ventana de tiempo para las tendencias de TheMovieDB.
/// El `name` coincide con el path del endpoint: /trending/.../day|week
enum TimeWindow {
  day,
  week;

  /// Etiqueta para mostrar en la UI.
  String get label => switch (this) {
        TimeWindow.day => 'Últimas 24h',
        TimeWindow.week => 'Esta semana',
      };
}

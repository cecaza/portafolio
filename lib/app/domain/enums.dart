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

/// Listas de películas de TheMovieDB que se consultan con paginación.
/// Endpoint: /3/movie/{path}?page=N
enum MovieCategory {
  nowPlaying('now_playing', 'En cartelera'),
  topRated('top_rated', 'Mejor valoradas'),
  upcoming('upcoming', 'Próximamente'),
  popular('popular', 'Populares');

  const MovieCategory(this.path, this.label);

  /// Segmento del endpoint en la API.
  final String path;

  /// Etiqueta para mostrar en la UI.
  final String label;
}

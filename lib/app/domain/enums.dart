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

/// Cómo se decide que una película es "match" en una sala de varias personas.
enum MatchMode {
  unanimous('unanimous', 'Todos coinciden', 'Match solo si a todos les gusta'),
  majority('majority', 'Por mayoría', 'Match si le gusta a más de la mitad');

  const MatchMode(this.id, this.label, this.description);

  /// Valor guardado en Firestore.
  final String id;

  /// Etiqueta para la UI.
  final String label;

  /// Descripción para la UI.
  final String description;

  static MatchMode fromId(String? id) => values.firstWhere(
        (m) => m.id == id,
        orElse: () => MatchMode.unanimous,
      );
}

/// Géneros de TheMovieDB. El `id` es el `genre_id` oficial de TMDB que se
/// envía a `/discover/movie?with_genres=...` para alimentar el deck de swipe
/// cuando la pareja no sabe qué ver y quiere descubrir por género.
enum MovieGenre {
  action(28, 'Acción'),
  adventure(12, 'Aventura'),
  animation(16, 'Animación'),
  comedy(35, 'Comedia'),
  crime(80, 'Crimen'),
  documentary(99, 'Documental'),
  drama(18, 'Drama'),
  family(10751, 'Familiar'),
  fantasy(14, 'Fantasía'),
  history(36, 'Historia'),
  horror(27, 'Terror'),
  music(10402, 'Música'),
  mystery(9648, 'Misterio'),
  romance(10749, 'Romance'),
  scienceFiction(878, 'Ciencia ficción'),
  thriller(53, 'Suspenso'),
  war(10752, 'Bélica'),
  western(37, 'Western');

  const MovieGenre(this.id, this.label);

  /// `genre_id` oficial de TheMovieDB.
  final int id;

  /// Etiqueta para mostrar en la UI (en español).
  final String label;
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

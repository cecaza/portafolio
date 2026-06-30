import '../enums.dart';
import 'movie.dart';

/// Una "sala de match": el espacio compartido donde un grupo (2 a 4 personas)
/// hace swipe sobre películas. Se identifica con un [code] corto que alguien
/// comparte y los demás usan para entrar.
class MatchRoom {
  const MatchRoom({
    required this.id,
    required this.code,
    required this.members,
    this.maxMembers = 2,
    this.mode = MatchMode.unanimous,
    this.genreIds = const [],
  });

  /// Id del documento en Firestore (rooms/{id}).
  final String id;

  /// Código corto para invitar (ej. "ABC123").
  final String code;

  /// UIDs (auth anónima) de los miembros.
  final List<String> members;

  /// Cupo máximo de la sala (2 a 4).
  final int maxMembers;

  /// Regla para declarar match (unánime o por mayoría).
  final MatchMode mode;

  /// Géneros elegidos para el modo "descubrir" (vacío = modo lista curada).
  final List<int> genreIds;

  bool get isFull => members.length >= maxMembers;

  /// Miembros distintos a [uid].
  List<String> others(String uid) =>
      members.where((m) => m != uid).toList();

  /// Construye desde un documento de Firestore.
  factory MatchRoom.fromMap(String id, Map<String, dynamic> map) {
    return MatchRoom(
      id: id,
      code: map['code'] as String? ?? '',
      members: (map['members'] as List<dynamic>? ?? const [])
          .map((e) => e as String)
          .toList(),
      maxMembers: (map['maxMembers'] as num?)?.toInt() ?? 2,
      mode: MatchMode.fromId(map['mode'] as String?),
      genreIds: (map['genreIds'] as List<dynamic>? ?? const [])
          .map((e) => (e as num).toInt())
          .toList(),
    );
  }
}

/// Una película marcada como match (a ambos les gustó) dentro de una sala.
class MovieMatch {
  const MovieMatch({required this.movie, this.matchedAtMillis});

  final Movie movie;

  /// Momento del match en epoch millis (puede ser null mientras el
  /// serverTimestamp se resuelve).
  final int? matchedAtMillis;
}

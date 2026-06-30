import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../../domain/models/movie.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../global/colors.dart';

/// Mazo de cartas estilo Tinder. Muestra la carta superior (arrastrable) y la
/// siguiente detrás. Al soltar más allá del umbral, o con los botones, dispara
/// [onSwipe] con `liked = true` (derecha) o `false` (izquierda).
class SwipeDeck extends StatefulWidget {
  const SwipeDeck({
    super.key,
    required this.cards,
    required this.onSwipe,
  });

  /// Cartas pendientes; la posición 0 es la de arriba.
  final List<Movie> cards;
  final void Function(Movie movie, {required bool liked}) onSwipe;

  @override
  State<SwipeDeck> createState() => SwipeDeckState();
}

class SwipeDeckState extends State<SwipeDeck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  Animation<Offset>? _flyAnimation;
  Offset _drag = Offset.zero;
  int? _topId;

  static const _threshold = 110.0;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        if (_flyAnimation != null) {
          setState(() => _drag = _flyAnimation!.value);
        }
      });
  }

  @override
  void didUpdateWidget(SwipeDeck oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newTop = widget.cards.isNotEmpty ? widget.cards.first.id : null;
    if (newTop != _topId) {
      _topId = newTop;
      _drag = Offset.zero;
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() => _drag += d.delta);
  }

  void _onPanEnd(DragEndDetails d) {
    if (_drag.dx.abs() > _threshold) {
      _flyOut(liked: _drag.dx > 0);
    } else {
      _settleBack();
    }
  }

  /// Swipe programático (botones).
  void swipeTop({required bool liked}) {
    if (widget.cards.isEmpty || _anim.isAnimating) return;
    _flyOut(liked: liked);
  }

  void _flyOut({required bool liked}) {
    final movie = widget.cards.first;
    final endX = (liked ? 1 : -1) * MediaQuery.sizeOf(context).width * 1.5;
    _flyAnimation = Tween<Offset>(
      begin: _drag,
      end: Offset(endX, _drag.dy),
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward(from: 0).then((_) {
      widget.onSwipe(movie, liked: liked);
      _flyAnimation = null;
      _drag = Offset.zero;
    });
  }

  void _settleBack() {
    _flyAnimation = Tween<Offset>(begin: _drag, end: Offset.zero)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward(from: 0).then((_) => _flyAnimation = null);
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.cards;
    if (cards.isEmpty) return const SizedBox.shrink();

    final rotation = (_drag.dx / 360).clamp(-0.4, 0.4);
    // Opacidad de los sellos LIKE / NOPE según el arrastre.
    final likeOpacity = (_drag.dx / _threshold).clamp(0.0, 1.0);
    final nopeOpacity = (-_drag.dx / _threshold).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Carta de atrás (la siguiente), un poco más pequeña.
            if (cards.length > 1)
              Transform.scale(
                scale: 0.94,
                child: _Card(movie: cards[1]),
              ),
            // Carta superior, arrastrable.
            Transform.translate(
              offset: _drag,
              child: Transform.rotate(
                angle: rotation,
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: _Card(
                    movie: cards.first,
                    likeOpacity: likeOpacity,
                    nopeOpacity: nopeOpacity,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.movie,
    this.likeOpacity = 0,
    this.nopeOpacity = 0,
  });

  final Movie movie;
  final double likeOpacity;
  final double nopeOpacity;

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    final year = (movie.releaseDate != null && movie.releaseDate!.length >= 4)
        ? movie.releaseDate!.substring(0, 4)
        : null;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 16, offset: Offset(0, 8)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (posterPath != null)
            Image.network(
              '${Constants.imagesBaseUrl}$posterPath',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(),
            )
          else
            _placeholder(),
          // Degradado para legibilidad del texto.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
          // Info inferior.
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: CinexaColors.orange, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                    if (year != null) ...[
                      const SizedBox(width: 12),
                      Text(year,
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Sellos LIKE / NOPE.
          Positioned(
            top: 24,
            left: 20,
            child: _Stamp(
              text: 'LIKE',
              color: Colors.greenAccent,
              opacity: likeOpacity,
              angle: -0.4,
            ),
          ),
          Positioned(
            top: 24,
            right: 20,
            child: _Stamp(
              text: 'NOPE',
              color: CinexaColors.coral,
              opacity: nopeOpacity,
              angle: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Assets.branding.placeholders.posterPlaceholderPng
        .image(fit: BoxFit.cover);
  }
}

class _Stamp extends StatelessWidget {
  const _Stamp({
    required this.text,
    required this.color,
    required this.opacity,
    required this.angle,
  });

  final String text;
  final Color color;
  final double opacity;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

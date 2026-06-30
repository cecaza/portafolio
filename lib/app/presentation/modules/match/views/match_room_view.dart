import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../config/constants.dart';
import '../../../../domain/models/movie.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../controller/match_controller.dart';
import 'genre_picker.dart';
import 'matches_view.dart';
import 'swipe_deck.dart';

/// Sala activa: deck de swipe, código para invitar, filtros y acceso a matches.
class MatchRoomView extends StatefulWidget {
  const MatchRoomView({super.key});

  @override
  State<MatchRoomView> createState() => _MatchRoomViewState();
}

class _MatchRoomViewState extends State<MatchRoomView> {
  final _deckKey = GlobalKey<SwipeDeckState>();

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Código copiado')),
    );
  }

  Future<void> _openGenres(MatchController controller) async {
    final result = await showGenrePicker(
      context,
      initial: controller.room!.genreIds,
    );
    if (result != null) {
      await controller.setGenres(result);
    }
  }

  void _openMatches(String roomId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => MatchesView(roomId: roomId)),
    );
  }

  void _showMatchCelebration(MatchController controller, Movie movie) {
    showDialog<void>(
      context: context,
      builder: (_) => _MatchDialog(
        movie: movie,
        onSeeMatches: () {
          Navigator.pop(context);
          _openMatches(controller.room!.id);
        },
      ),
    ).then((_) => controller.clearLastMatch());
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MatchController>();
    final room = controller.room!;

    // Celebración cuando llega un match nuevo.
    if (controller.lastMatch != null) {
      final movie = controller.lastMatch!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && controller.lastMatch != null) {
          _showMatchCelebration(controller, movie);
        }
      });
    }

    final deck = controller.deck;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sala ${room.code}'),
        actions: [
          IconButton(
            tooltip: 'Géneros',
            icon: const Icon(Icons.tune),
            onPressed: () => _openGenres(controller),
          ),
          IconButton(
            tooltip: 'Matches',
            icon: const Icon(Icons.favorite),
            onPressed: () => _openMatches(room.id),
          ),
          IconButton(
            tooltip: 'Salir',
            icon: const Icon(Icons.logout),
            onPressed: controller.leaveRoom,
          ),
        ],
      ),
      body: Column(
        children: [
          if (!room.isFull)
            _WaitingBanner(
              code: room.code,
              current: room.members.length,
              max: room.maxMembers,
              onCopy: _copyCode,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: _buildDeckArea(controller, deck),
            ),
          ),
          if (deck.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ActionButton(
                    icon: Icons.close,
                    color: CinexaColors.coral,
                    onTap: () => _deckKey.currentState?.swipeTop(liked: false),
                  ),
                  const SizedBox(width: 48),
                  _ActionButton(
                    icon: Icons.favorite,
                    color: Colors.greenAccent,
                    onTap: () => _deckKey.currentState?.swipeTop(liked: true),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeckArea(MatchController controller, List<Movie> deck) {
    if (deck.isEmpty) {
      if (controller.loadingDeck) return const CinexaLoader();
      return _EmptyDeck(
        inDiscoverMode: controller.inDiscoverMode,
        onPickGenres: () => _openGenres(controller),
      );
    }
    return SwipeDeck(
      key: _deckKey,
      cards: deck,
      onSwipe: (movie, {required bool liked}) =>
          controller.swipe(movie, liked: liked),
    );
  }
}

class _WaitingBanner extends StatelessWidget {
  const _WaitingBanner({
    required this.code,
    required this.current,
    required this.max,
    required this.onCopy,
  });

  final String code;
  final int current;
  final int max;
  final void Function(String code) onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CinexaColors.ink2,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.hourglass_top, color: CinexaColors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 13),
                children: [
                  TextSpan(
                      text: '$current de $max unidos · '
                          'comparte el código:\n'),
                  TextSpan(
                    text: code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => onCopy(code),
            icon: const Icon(Icons.copy, size: 18),
            label: const Text('Copiar'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CinexaColors.ink2,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Icon(icon, color: color, size: 32),
        ),
      ),
    );
  }
}

class _EmptyDeck extends StatelessWidget {
  const _EmptyDeck({required this.inDiscoverMode, required this.onPickGenres});

  final bool inDiscoverMode;
  final VoidCallback onPickGenres;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.movie_filter_outlined,
              size: 64, color: CinexaColors.muted),
          const SizedBox(height: 16),
          Text(
            inDiscoverMode
                ? 'No quedan más sugerencias por ahora'
                : 'Su lista está vacía',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Prueba con otros géneros para seguir descubriendo',
            textAlign: TextAlign.center,
            style: TextStyle(color: CinexaColors.muted),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onPickGenres,
            icon: const Icon(Icons.tune),
            label: const Text('Elegir géneros'),
          ),
        ],
      ),
    );
  }
}

class _MatchDialog extends StatelessWidget {
  const _MatchDialog({required this.movie, required this.onSeeMatches});

  final Movie movie;
  final VoidCallback onSeeMatches;

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    return Dialog(
      backgroundColor: CinexaColors.ink2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¡Es match! 🍿',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: CinexaColors.coral,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'A los dos les gustó',
              style: TextStyle(color: CinexaColors.muted),
            ),
            const SizedBox(height: 16),
            if (posterPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '${Constants.imagesBaseUrl}$posterPath',
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Seguir'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: onSeeMatches,
                    child: const Text('Ver matches'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

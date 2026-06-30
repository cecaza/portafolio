import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/match_controller.dart';
import 'match_lobby_view.dart';
import 'match_room_view.dart';

/// Punto de entrada del módulo de match. Provee el [MatchController] y muestra
/// el lobby (crear/unir sala) o la sala activa según el estado.
class MatchView extends StatelessWidget {
  const MatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchController>(
      create: (_) => MatchController()..init(),
      child: Consumer<MatchController>(
        builder: (_, controller, __) {
          if (controller.room == null) {
            return const MatchLobbyView();
          }
          return const MatchRoomView();
        },
      ),
    );
  }
}

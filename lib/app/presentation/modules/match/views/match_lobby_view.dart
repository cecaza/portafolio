import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../global/colors.dart';
import '../controller/match_controller.dart';
import 'create_room_sheet.dart';

/// Lobby del match: crear una sala nueva o unirse a una con su código.
class MatchLobbyView extends StatefulWidget {
  const MatchLobbyView({super.key});

  @override
  State<MatchLobbyView> createState() => _MatchLobbyViewState();
}

class _MatchLobbyViewState extends State<MatchLobbyView> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _join(MatchController controller) async {
    FocusScope.of(context).unfocus();
    await controller.joinRoom(_codeController.text);
  }

  Future<void> _create(MatchController controller) async {
    final options = await showCreateRoomSheet(context);
    if (options == null) return;
    await controller.createRoom(
      maxMembers: options.maxMembers,
      mode: options.mode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MatchController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Match en pareja')),
      body: AbsorbPointer(
        absorbing: controller.busy,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 8),
            const Icon(Icons.favorite, color: CinexaColors.coral, size: 56),
            const SizedBox(height: 12),
            const Text(
              'Decidan juntos qué ver',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Creen una sala, compartan el código y hagan swipe. '
              'Cuando a los dos les guste la misma película, ¡es match!',
              textAlign: TextAlign.center,
              style: TextStyle(color: CinexaColors.muted),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: controller.busy ? null : () => _create(controller),
              icon: const Icon(Icons.add),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Crear una sala'),
              ),
            ),
            const SizedBox(height: 28),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child:
                      Text('o únete', style: TextStyle(color: CinexaColors.muted)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              textCapitalization: TextCapitalization.characters,
              textAlign: TextAlign.center,
              maxLength: 6,
              style: const TextStyle(
                fontSize: 24,
                letterSpacing: 8,
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
              ],
              decoration: const InputDecoration(
                hintText: 'CÓDIGO',
                counterText: '',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _join(controller),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: controller.busy ? null : () => _join(controller),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Unirme a la sala'),
              ),
            ),
            if (controller.error != null) ...[
              const SizedBox(height: 16),
              Text(
                controller.error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: CinexaColors.coral),
              ),
            ],
            if (controller.busy) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}

/// Convierte el texto a mayúsculas mientras se escribe (para el código).
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

import 'package:flutter/material.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';

/// Opciones elegidas al crear una sala.
class CreateRoomOptions {
  const CreateRoomOptions({required this.maxMembers, required this.mode});

  final int maxMembers;
  final MatchMode mode;
}

/// Hoja para configurar una sala nueva: cuántas personas y cómo se decide el
/// match. Devuelve null si se cancela.
Future<CreateRoomOptions?> showCreateRoomSheet(BuildContext context) {
  return showModalBottomSheet<CreateRoomOptions>(
    context: context,
    isScrollControlled: true,
    backgroundColor: CinexaColors.ink2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const _CreateRoomSheet(),
  );
}

class _CreateRoomSheet extends StatefulWidget {
  const _CreateRoomSheet();

  @override
  State<_CreateRoomSheet> createState() => _CreateRoomSheetState();
}

class _CreateRoomSheetState extends State<_CreateRoomSheet> {
  int _maxMembers = 2;
  MatchMode _mode = MatchMode.unanimous;

  @override
  Widget build(BuildContext context) {
    // Con 2 personas el modo no aplica (unánime == mayoría).
    final showMode = _maxMembers > 2;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nueva sala',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('¿Cuántos van a participar?',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 2, label: Text('2')),
                ButtonSegment(value: 3, label: Text('3')),
                ButtonSegment(value: 4, label: Text('4')),
              ],
              selected: {_maxMembers},
              onSelectionChanged: (s) =>
                  setState(() => _maxMembers = s.first),
            ),
            if (showMode) ...[
              const SizedBox(height: 24),
              const Text('¿Cómo deciden el match?',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              RadioGroup<MatchMode>(
                groupValue: _mode,
                onChanged: (v) => setState(() => _mode = v!),
                child: Column(
                  children: [
                    for (final m in MatchMode.values)
                      RadioListTile<MatchMode>(
                        value: m,
                        contentPadding: EdgeInsets.zero,
                        title: Text(m.label),
                        subtitle: Text(
                          m.description,
                          style: const TextStyle(
                              color: CinexaColors.muted, fontSize: 12),
                        ),
                        activeColor: CinexaColors.coral,
                      ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(
                  context,
                  CreateRoomOptions(
                    maxMembers: _maxMembers,
                    // Con 2 personas siempre es unánime.
                    mode: _maxMembers > 2 ? _mode : MatchMode.unanimous,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Crear sala'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

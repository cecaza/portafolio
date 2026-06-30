import 'package:flutter/material.dart';

import '../../../../domain/enums.dart';
import '../../../global/colors.dart';

/// Muestra una hoja inferior para elegir géneros. Devuelve la lista de ids
/// elegidos (vacía = modo lista curada), o null si se cancela.
Future<List<int>?> showGenrePicker(
  BuildContext context, {
  required List<int> initial,
}) {
  return showModalBottomSheet<List<int>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: CinexaColors.ink2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _GenrePickerSheet(initial: initial.toSet()),
  );
}

class _GenrePickerSheet extends StatefulWidget {
  const _GenrePickerSheet({required this.initial});

  final Set<int> initial;

  @override
  State<_GenrePickerSheet> createState() => _GenrePickerSheetState();
}

class _GenrePickerSheetState extends State<_GenrePickerSheet> {
  late final Set<int> _selected = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Qué les provoca ver?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Elige géneros para descubrir, o ninguno para usar su lista.',
              style: TextStyle(color: CinexaColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final g in MovieGenre.values)
                  FilterChip(
                    label: Text(g.label),
                    selected: _selected.contains(g.id),
                    onSelected: (on) => setState(
                      () => on ? _selected.add(g.id) : _selected.remove(g.id),
                    ),
                    selectedColor: CinexaColors.coral,
                    checkmarkColor: Colors.white,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pop(context, <int>[]), // sin géneros
                    child: const Text('Usar nuestra lista'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () =>
                        Navigator.pop(context, _selected.toList()),
                    child: const Text('Aplicar'),
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

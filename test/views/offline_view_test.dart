import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portafolio/app/presentation/modules/offline/views/offline_view.dart';

void main() {
  testWidgets('OfflineView muestra el mensaje de offline', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OfflineView()));

    expect(find.text('Offline'), findsOneWidget);
  });
}

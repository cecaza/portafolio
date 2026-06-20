import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portafolio/app/presentation/global/controllers/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('por defecto el tema es oscuro', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final controller = ThemeController(prefs);

    expect(controller.isDark, isTrue);
    expect(controller.mode, ThemeMode.dark);
  });

  test('lee el tema guardado (light)', () async {
    SharedPreferences.setMockInitialValues({'themeMode': 'light'});
    final prefs = await SharedPreferences.getInstance();

    final controller = ThemeController(prefs);

    expect(controller.isDark, isFalse);
  });

  test('toggle cambia el tema y lo persiste', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final controller = ThemeController(prefs);

    await controller.toggle();

    expect(controller.isDark, isFalse);
    expect(prefs.getString('themeMode'), 'light');
  });
}

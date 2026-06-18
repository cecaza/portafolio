// Importa la implementación correcta según la plataforma:
//  - web  -> internet_checker_web.dart    (no usa dart:io)
//  - resto -> internet_checker_native.dart (usa dart:io)
import 'internet_checker_web.dart'
    if (dart.library.io) 'internet_checker_native.dart' as impl;

class InternetChecker {
  Future<bool> hasInternet() => impl.hasInternet();
}

import 'dart:io';

/// Comprobación real de internet en móvil/escritorio: resuelve un dominio.
Future<bool> hasInternet() async {
  try {
    final list = await InternetAddress.lookup('google.com');
    return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

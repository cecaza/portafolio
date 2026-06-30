import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

/// Implementación web del flujo de instalación de PWA.
///
/// El navegador dispara el evento `beforeinstallprompt` cuando la app es
/// instalable. Lo guardamos para poder lanzar la instalación al pulsar el
/// botón "Instalar".
JSObject? _deferredPrompt;

void initPwa() {
  web.window.callMethod(
    'addEventListener'.toJS,
    'beforeinstallprompt'.toJS,
    ((web.Event event) {
      event.preventDefault();
      _deferredPrompt = event as JSObject;
    }).toJS,
  );
}

bool canInstallPwa() => _deferredPrompt != null;

Future<void> installPwa() async {
  final prompt = _deferredPrompt;
  if (prompt == null) return;
  prompt.callMethod('prompt'.toJS);
  _deferredPrompt = null;
}

/// Descarga el APK de Android. El archivo `cinexa.apk` se sirve junto a la web
/// (mismo origen), así que basta un enlace relativo con atributo `download`.
void downloadApk() {
  final anchor = web.HTMLAnchorElement()
    ..href = 'cinexa.apk'
    ..setAttribute('download', 'cinexa.apk');
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}

// Fachada para el flujo de instalación PWA. Elige la implementación correcta
// según la plataforma (web vs móvil) mediante import condicional.
export 'pwa_stub.dart' if (dart.library.js_interop) 'pwa_web.dart';

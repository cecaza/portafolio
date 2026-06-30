/// Implementación para plataformas que NO son web (móvil/escritorio nativo).
/// Aquí no hay nada que instalar, así que son operaciones vacías.
void initPwa() {}

bool canInstallPwa() => false;

Future<void> installPwa() async {}

/// Solo aplica en web; en nativo no hace nada.
void downloadApk() {}

import 'package:flutter/foundation.dart';

import '../../../domain/models/user.dart';

/// Estado GLOBAL de la sesión: guarda el usuario logueado y avisa a toda la
/// app cuando cambia. Vive en el tope del árbol (ver main.dart) para que
/// cualquier pantalla pueda leerlo.
class SessionController extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool get isSignedIn => _user != null;

  /// Guarda (o reemplaza) el usuario de la sesión actual.
  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  /// Limpia la sesión (al cerrar sesión).
  void clear() {
    _user = null;
    notifyListeners();
  }
}

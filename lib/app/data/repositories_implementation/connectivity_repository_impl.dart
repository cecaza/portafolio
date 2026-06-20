import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/repositories/connectivity_repository.dart';
import '../services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  );

  final Connectivity _connectivity;
  final InternetChecker _internetChecker;

  @override
  Future<bool> get hasInternet async {
    final result = await _connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      return false; // NO hay conexión a internet
    }
    return _internetChecker.hasInternet();
  }

  @override
  Stream<bool> get onInternetChanged async* {
    // Emitimos el estado actual al suscribirse...
    yield await hasInternet;
    // ...y luego uno nuevo cada vez que cambia la conectividad.
    await for (final _ in _connectivity.onConnectivityChanged) {
      yield await hasInternet;
    }
  }
}

abstract class ConnectivityRepository {
  /// Comprobación puntual (una vez) de si hay internet.
  Future<bool> get hasInternet;

  /// Stream que emite el estado de internet cada vez que cambia la conexión.
  /// `true` = hay internet, `false` = sin conexión.
  Stream<bool> get onInternetChanged;
}

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  //verificamos si tenemos internet
  final Connectivity _connectivity;

  ConnectivityRepositoryImpl(this._connectivity); //injectamos la dependencia

  @override
  Future<bool> get hasInternet async {
    final result = await _connectivity.checkConnectivity();

    if (result.contains((ConnectivityResult.none))) {
      return false; // NO Hay conexión a internet
    }
    return _hasInternet();
  }

  Future<bool> _hasInternet() async {
    try {
      final list = await InternetAddress.lookup('google.com');
      return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

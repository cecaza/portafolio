import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/repositories_implementation/connectivity_repository_impl.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockConnectivity connectivity;
  late MockInternetChecker internetChecker;
  late ConnectivityRepositoryImpl repository;

  setUp(() {
    connectivity = MockConnectivity();
    internetChecker = MockInternetChecker();
    repository = ConnectivityRepositoryImpl(connectivity, internetChecker);
  });

  group('ConnectivityRepository.hasInternet', () {
    test('devuelve false si no hay conexión (none)', () async {
      when(connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await repository.hasInternet;

      expect(result, isFalse);
      // Si no hay red, ni siquiera intenta comprobar internet real.
      verifyNever(internetChecker.hasInternet());
    });

    test('devuelve true si hay wifi e internet real', () async {
      when(connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(internetChecker.hasInternet()).thenAnswer((_) async => true);

      final result = await repository.hasInternet;

      expect(result, isTrue);
    });

    test('devuelve false si hay red pero no internet real', () async {
      when(connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.mobile]);
      when(internetChecker.hasInternet()).thenAnswer((_) async => false);

      final result = await repository.hasInternet;

      expect(result, isFalse);
    });
  });
}

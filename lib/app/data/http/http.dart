import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';
import '../../domain/enums.dart';

/// Métodos HTTP soportados por el wrapper.
enum HttpMethod { get, post, put, patch, delete }

/// Información de un fallo HTTP, lista para mapear a errores de dominio.
class HttpFailure {
  HttpFailure({
    this.statusCode,
    this.exception,
    this.data,
    this.type = HttpFailureType.unknown,
  });

  /// Código de estado HTTP. `null` cuando ni siquiera hubo respuesta (red).
  final int? statusCode;

  /// Excepción capturada (sin conexión, timeout, parseo, etc.).
  final Object? exception;

  /// Cuerpo de la respuesta ya decodificado (cuando exista).
  final dynamic data;

  final HttpFailureType type;
}

/// Cliente HTTP que centraliza peticiones y siempre devuelve un [Either]:
/// [Left] con [HttpFailure] en error, o [Right] con el dato parseado en éxito.
class Http {
  Http({
    required Client client,
    required String baseUrl,
    required String accessToken,
    this.enableLog = kDebugMode,
  })  : _client = client,
        _baseUrl = baseUrl,
        _accessToken = accessToken;

  final Client _client;
  final String _baseUrl;
  final String _accessToken;

  /// Si es `true`, imprime cada petición y respuesta en consola.
  /// Por defecto solo en modo debug.
  final bool enableLog;

  Future<Either<HttpFailure, R>> request<R>(
    String path, {
    HttpMethod method = HttpMethod.get,
    R Function(dynamic responseBody)? parser,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Map<String, dynamic>? responseBody;
    int? statusCode;
    final url = Uri.https(
      _baseUrl,
      path,
      queryParameters.isEmpty ? null : queryParameters,
    );
    try {
      final requestHeaders = {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $_accessToken',
        ...headers,
      };

      late final Response response;
      final encodedBody = body.isEmpty ? null : jsonEncode(body);

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url, headers: requestHeaders);
        case HttpMethod.post:
          response = await _client.post(url,
              headers: requestHeaders, body: encodedBody);
        case HttpMethod.put:
          response = await _client.put(url,
              headers: requestHeaders, body: encodedBody);
        case HttpMethod.patch:
          response = await _client.patch(url,
              headers: requestHeaders, body: encodedBody);
        case HttpMethod.delete:
          response = await _client.delete(url,
              headers: requestHeaders, body: encodedBody);
      }

      statusCode = response.statusCode;
      responseBody =
          response.body.isEmpty ? null : jsonDecode(response.body);

      _log(method, url, body, statusCode, response.body);

      if (statusCode >= 200 && statusCode < 300) {
        return Right(
          parser != null ? parser(responseBody) : responseBody as R,
        );
      }

      return Left(
        HttpFailure(
          statusCode: statusCode,
          data: responseBody,
          type: _failureTypeFromStatusCode(statusCode),
        ),
      );
    } catch (e) {
      _log(method, url, body, statusCode, e.toString());
      return Left(
        HttpFailure(
          statusCode: statusCode,
          exception: e,
          data: responseBody,
          type: statusCode == null
              ? HttpFailureType.network
              : HttpFailureType.unknown,
        ),
      );
    }
  }

  void _log(
    HttpMethod method,
    Uri url,
    Map<String, dynamic> body,
    int? statusCode,
    String responseBody,
  ) {
    if (!enableLog) {
      return;
    }
    log(
      '''
╔══════════════════════════════════════════════════
║ ${method.name.toUpperCase()}  $url
║ statusCode: ${statusCode ?? 'NO RESPONSE (network error)'}
║ request body: ${body.isEmpty ? '—' : jsonEncode(body)}
║ response: $responseBody
╚══════════════════════════════════════════════════''',
      name: 'Http',
    );
  }

  HttpFailureType _failureTypeFromStatusCode(int statusCode) {
    return switch (statusCode) {
      401 => HttpFailureType.unauthorized,
      403 => HttpFailureType.forbidden,
      404 => HttpFailureType.notFound,
      >= 500 => HttpFailureType.server,
      _ => HttpFailureType.unknown,
    };
  }
}

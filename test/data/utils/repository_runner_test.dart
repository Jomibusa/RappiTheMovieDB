import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rappi_themoviedb/data/utils/repository_runner.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';

DioException _dioException({
  int? statusCode,
  DioExceptionType type = DioExceptionType.badResponse,
}) {
  return DioException(
    requestOptions: RequestOptions(path: '/test'),
    type: type,
    response: statusCode != null
        ? Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: statusCode,
          )
        : null,
  );
}

void main() {
  group('repositoryRun', () {
    test(
        'Given una llamada exitosa, '
        'When se ejecuta, '
        'Then retorna el valor sin modificarlo', () async {
      // When
      final result = await repositoryRun(() async => 42);

      // Then
      expect(result, 42);
    });

    test(
        'Given una DioException de timeout de conexión, '
        'When ocurre el error, '
        'Then lanza TimeoutFailure', () async {
      // When / Then
      expect(
        () => repositoryRun(() => Future.error(
              _dioException(type: DioExceptionType.connectionTimeout),
            )),
        throwsA(isA<TimeoutFailure>()),
      );
    });

    test(
        'Given una DioException de timeout de recepción, '
        'When ocurre el error, '
        'Then lanza TimeoutFailure', () async {
      expect(
        () => repositoryRun(() => Future.error(
              _dioException(type: DioExceptionType.receiveTimeout),
            )),
        throwsA(isA<TimeoutFailure>()),
      );
    });

    test(
        'Given una DioException con status 401, '
        'When ocurre el error, '
        'Then lanza UnauthorizedFailure', () {
      expect(
        () => repositoryRun(() => Future.error(_dioException(statusCode: 401))),
        throwsA(isA<UnauthorizedFailure>()),
      );
    });

    test(
        'Given una DioException con status 403, '
        'When ocurre el error, '
        'Then lanza UnauthorizedFailure', () {
      expect(
        () => repositoryRun(() => Future.error(_dioException(statusCode: 403))),
        throwsA(isA<UnauthorizedFailure>()),
      );
    });

    test(
        'Given una DioException con status 404, '
        'When ocurre el error, '
        'Then lanza NotFoundFailure', () {
      expect(
        () => repositoryRun(() => Future.error(_dioException(statusCode: 404))),
        throwsA(isA<NotFoundFailure>()),
      );
    });

    test(
        'Given una DioException con status 500, '
        'When ocurre el error, '
        'Then lanza ServerFailure con el código de estado', () async {
      await expectLater(
        () => repositoryRun(() => Future.error(_dioException(statusCode: 500))),
        throwsA(
          isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 500),
        ),
      );
    });

    test(
        'Given una DioException sin respuesta HTTP, '
        'When ocurre el error, '
        'Then lanza NetworkFailure', () {
      expect(
        () => repositoryRun(() => Future.error(
              _dioException(type: DioExceptionType.unknown),
            )),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test(
        'Given un FormatException al parsear la respuesta, '
        'When ocurre el error, '
        'Then lanza ParseFailure', () {
      expect(
        () => repositoryRun(
            () => Future.error(const FormatException('bad json'))),
        throwsA(isA<ParseFailure>()),
      );
    });

    test(
        'Given una excepción desconocida, '
        'When ocurre el error, '
        'Then lanza UnknownFailure con la causa original', () async {
      final cause = Exception('algo raro');
      await expectLater(
        () => repositoryRun(() => Future.error(cause)),
        throwsA(
          isA<UnknownFailure>().having((f) => f.cause, 'cause', cause),
        ),
      );
    });

    test(
        'Given un AppFailure ya tipado lanzado internamente, '
        'When ocurre el error, '
        'Then lo relanza sin envolverlo en UnknownFailure', () {
      expect(
        () => repositoryRun(
            () => Future.error(const NetworkFailure())),
        throwsA(isA<NetworkFailure>()),
      );
    });
  });
}

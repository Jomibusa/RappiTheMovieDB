import 'package:dio/dio.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';

Future<T> repositoryRun<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw const TimeoutFailure();
    }
    if (e.type == DioExceptionType.connectionError) {
      throw const NetworkFailure();
    }
    final status = e.response?.statusCode;
    if (status == 401 || status == 403) throw const UnauthorizedFailure();
    if (status == 404) throw const NotFoundFailure('');
    if (status != null && status >= 500) throw ServerFailure(status);
    throw const NetworkFailure();
  } on FormatException catch (e) {
    throw ParseFailure(e);
  } on AppFailure {
    rethrow;
  } catch (e) {
    throw UnknownFailure(e);
  }
}

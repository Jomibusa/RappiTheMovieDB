sealed class AppFailure {
  const AppFailure();
}

class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

class ServerFailure extends AppFailure {
  final int statusCode;
  const ServerFailure(this.statusCode);
}

class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure();
}

class TimeoutFailure extends AppFailure {
  const TimeoutFailure();
}

class NotFoundFailure extends AppFailure {
  final String id;
  const NotFoundFailure(this.id);
}

class ParseFailure extends AppFailure {
  final Object cause;
  const ParseFailure(this.cause);
}

class UnknownFailure extends AppFailure {
  final Object cause;
  const UnknownFailure(this.cause);
}

/// Exception yang digunakan dalam layer data
abstract class Exceptions implements Exception {
  final String message;
  const Exceptions(this.message);
}

/// Exception untuk server error
class ServerException implements Exceptions {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Code: $statusCode)';
}

/// Exception untuk cache error
class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

/// Exception untuk network error
class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

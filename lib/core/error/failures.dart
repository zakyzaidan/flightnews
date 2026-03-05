/// Failure yang digunakan dalam domain/presentation layer
abstract class Failure {
  final String message;
  const Failure({required this.message});
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message: message);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure({required String message}) : super(message: message);
}

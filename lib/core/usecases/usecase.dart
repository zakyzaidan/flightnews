import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Base class untuk semua use cases
/// Type Parameters:
/// - [Success] : Tipe data yang dikembalikan saat berhasil
/// - [Params] : Tipe parameter input untuk use case
abstract class UseCase<Success, Params> {
  /// Memanggil use case untuk mendapatkan data
  Future<Either<Failure, Success>> call(Params params);
}

/// Use case yang tidak memerlukan parameter
class NoParams {
  const NoParams();
}

import '../network/app_error_type.dart';
import '../network/either.dart';

abstract class UseCase<R, P> {
  Future<Either<AppError, R>> call(P params);
}

class NoParams {
  const NoParams();
}

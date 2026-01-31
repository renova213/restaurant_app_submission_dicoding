abstract class Either<L, R> {
  const Either();

  bool get isLeft;
  bool get isRight;

  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight);
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) {
    return onLeft(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) {
    return onRight(value);
  }
}

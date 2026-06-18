/// Representa un valor que puede ser de tipo [Left] (error) o [Right] (éxito).
///
/// Por convención, [Left] contiene el caso de error y [Right] el caso exitoso.
sealed class Either<L, R> {
  const Either();

  /// `true` si esta instancia es un [Left] (error).
  bool get isLeft => this is Left<L, R>;

  /// `true` si esta instancia es un [Right] (éxito).
  bool get isRight => this is Right<L, R>;

  /// Ejecuta [left] si es un error o [right] si es un éxito y devuelve el
  /// resultado. Es la forma segura de "desempaquetar" el valor.
  T when<T>(
    T Function(L left) left,
    T Function(R right) right,
  ) {
    if (this is Left<L, R>) {
      return left((this as Left<L, R>).value);
    }
    return right((this as Right<L, R>).value);
  }
}

class Left<L, R> extends Either<L, R> {
  const Left(this.value);

  final L value;
}

class Right<L, R> extends Either<L, R> {
  const Right(this.value);

  final R value;
}

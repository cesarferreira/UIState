import 'package:meta/meta.dart';

// part 'ui_state.g.dart';

@sealed
class UIState<T> extends SealedResult<T> {}

class Success<T> extends UIState<T> {
  T value;

  Success(this.value);
}

class Failure<T> extends UIState<T> {
  String errorMessage;
  Failure(this.errorMessage);
}

class Loading<T> extends UIState<T> {}

class SealedResult<T> {
  R when<R>({
    required R Function(Success<T>) success,
    required R Function(Failure<T>) failure,
    required R Function(Loading<T>) loading,
  }) {
    if (this is Success<T>) {
      return success(this as Success<T>);
    }
    if (this is Failure<T>) {
      return failure(this as Failure<T>);
    }
    if (this is Loading<T>) {
      return loading(this as Loading<T>);
    }
    throw new Exception('Should never get here');
  }
}

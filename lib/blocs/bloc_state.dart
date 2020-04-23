abstract class BlocState {}

class Waiting extends BlocState {
  bool isThrowback = false;
  Waiting({this.isThrowback});
}

class Loading extends BlocState {}

class Success extends BlocState {
  final result;

  Success(this.result);
}

class Error extends BlocState {
  final error;

  Error(this.error);
}

class InitCheck extends BlocState {}

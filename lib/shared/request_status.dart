abstract class RequsetState {}

class IdleState extends RequsetState {}

class LoadingState extends RequsetState {}

class SuccessState extends RequsetState {}

class ErrorState extends RequsetState {
  final String error;
  ErrorState(this.error);
}

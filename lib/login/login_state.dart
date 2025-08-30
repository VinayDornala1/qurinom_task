

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginLoaded extends LoginState {
  final String token;
  // final String password;
  LoginLoaded({required this.token});
}
final class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
}

part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponseModel responseModel;

  LoginSuccess({required this.responseModel});
}

final class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

final class ForgotPasswordSuccess extends LoginState {
  final String message;
  final String email;
  final String token;

  ForgotPasswordSuccess({
    required this.message,
    required this.email,
    required this.token,
  });
}


final class ResetPasswordSuccess extends LoginState {
  final String message;

  ResetPasswordSuccess({required this.message});
}

final class LogoutSuccess extends LoginState {}


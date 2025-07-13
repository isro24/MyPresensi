part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginRequested extends LoginEvent {
  final LoginRequestModel requestModel;

  LoginRequested({required this.requestModel});
}

class ForgotPasswordRequested extends LoginEvent {
  final ForgotPasswordRequestModel request;

  ForgotPasswordRequested({required this.request});
}

class ResetPasswordRequested extends LoginEvent {
  final ResetPasswordRequestModel request;

  ResetPasswordRequested({required this.request});
}

class LogoutRequested extends LoginEvent {} 

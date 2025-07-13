import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/request/auth/forgot_password_request_model.dart';
import 'package:my_presensi/data/models/request/auth/login_request_model.dart';
import 'package:my_presensi/data/models/request/auth/reset_password_request_model.dart';
import 'package:my_presensi/data/models/response/auth/login_response_model.dart';
import 'package:my_presensi/data/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested> (_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await authRepository.login(event.requestModel);
    
    result.fold(
      (l) => emit(LoginFailure(error: l)),
      (r) => emit(LoginSuccess(responseModel: r)),
    );
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final response = await authRepository.forgotPassword(event.request);
    response.fold(
      (l) => emit(LoginFailure(error: l)),
      (r) => emit(ForgotPasswordSuccess(
        message: r['message']!,
        email: r['email']!,
        token: r['token']!,
      )),
    );
  }


  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final response = await authRepository.resetPassword(event.request);
    response.fold(
      (l) => emit(LoginFailure(error: l)),
      (r) => emit(ResetPasswordSuccess(message: r)),
    );
  }

  Future<void> _onLogoutRequested( 
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    await authRepository.logout();
    emit(LogoutSuccess()); 
  }
}

import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/request/auth/login_request_model.dart';
import 'package:my_presensi/data/models/response/auth/login_response_model.dart';
import 'package:my_presensi/data/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested> (_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
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

  Future<void> _onLogoutRequested( 
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    await authRepository.logout();
    emit(LogoutSuccess()); 
  }
}

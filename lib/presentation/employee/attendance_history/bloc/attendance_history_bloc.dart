import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/response/employee/employee_attendance_response_model.dart';
import 'package:my_presensi/data/repository/employee/employee_attendance_repository.dart';

part 'attendance_history_event.dart';
part 'attendance_history_state.dart';

class EmployeeAttendanceHistoryBloc extends Bloc<AttendanceHistoryEvent, AttendanceHistoryState> {
  final EmployeeAttendanceRepository employeeAttendanceRepository;

  EmployeeAttendanceHistoryBloc({required this.employeeAttendanceRepository}) : super(AttendanceHistoryInitial()) {
    on<LoadAttendanceHistoryEvent>(_loadAttendanceHistory);
    on<ResetAttendanceHistoryStateEvent>(_resetAttendanceHistoryState);
    on<LoadAttendanceDetailEvent>((event, emit) {
      emit(AttendanceHistoryDetailLoaded(detail: event.attendance));
    });

  }

  Future<void> _loadAttendanceHistory(
    LoadAttendanceHistoryEvent event,
    Emitter<AttendanceHistoryState> emit,
  ) async {
    emit(AttendanceHistoryLoading());

    final result = await employeeAttendanceRepository.getAttendanceHistory();

    result.fold(
      (error) => emit(AttendanceHistoryError(message: error)),
      (list) => emit(AttendanceHistoryLoaded(history: list)),
    );
  }

  Future<void> _resetAttendanceHistoryState(
    ResetAttendanceHistoryStateEvent event,
    Emitter<AttendanceHistoryState> emit,
  ) async {
    final currentState = state;

    if (currentState is AttendanceHistoryLoaded) {
      emit(AttendanceHistoryLoaded(history: currentState.history));
    } else if (currentState is AttendanceHistoryError) {
      emit(AttendanceHistoryInitial());
    } else {
      emit(AttendanceHistoryInitial());
    }
  }
}

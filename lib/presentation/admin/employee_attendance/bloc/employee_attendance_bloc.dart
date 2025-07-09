import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_attendance_response_model.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_attendance_repository.dart';

part 'employee_attendance_event.dart';
part 'employee_attendance_state.dart';

class EmployeeAttendanceBloc extends Bloc<EmployeeAttendanceEvent, EmployeeAttendanceState> {
  final AdminEmployeeAttendanceRepository adminEmployeeAttendanceRepository;

  EmployeeAttendanceBloc(this.adminEmployeeAttendanceRepository) : super(EmployeeAttendanceInitial()) {
    on<GetAllEmployeeAttendanceEvent>((event, emit) async {
      emit(EmployeeAttendanceLoading());
      final result = await adminEmployeeAttendanceRepository.getAllEmployeeAttendance();

      result.fold(
        (error) => emit(EmployeeAttendanceError(error)),
        (data) => emit(EmployeeAttendanceLoaded(data)),
      );
    });


    on<DeleteEmployeeAttendanceEvent>((event, emit) async {
      emit(EmployeeAttendanceLoading());
      final result = await adminEmployeeAttendanceRepository.deleteAttendance(event.id);
      result.fold(
        (error) => emit(EmployeeAttendanceError(error)),
        (message) => emit(EmployeeAttendanceDeleted(message)),
      );
    });
  }
}

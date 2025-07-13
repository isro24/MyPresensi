part of 'employee_attendance_bloc.dart';

sealed class EmployeeAttendanceState {}

class EmployeeAttendanceInitial extends EmployeeAttendanceState {}

class EmployeeAttendanceLoading extends EmployeeAttendanceState {}

class EmployeeAttendanceLoaded extends EmployeeAttendanceState {
  final List<EmployeeAttendanceData> data;
  EmployeeAttendanceLoaded(this.data);
}

class EmployeeAttendanceDeleted extends EmployeeAttendanceState {
  final String message;
  EmployeeAttendanceDeleted(this.message);
}

class EmployeeAttendanceExportedToPdf extends EmployeeAttendanceState {}

class EmployeeAttendanceError extends EmployeeAttendanceState {
  final String message;
  EmployeeAttendanceError(this.message);
}

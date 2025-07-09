part of 'employee_attendance_bloc.dart';

sealed class EmployeeAttendanceEvent {}

class GetAllEmployeeAttendanceEvent extends EmployeeAttendanceEvent {}

class DeleteEmployeeAttendanceEvent extends EmployeeAttendanceEvent {
  final int id;
  DeleteEmployeeAttendanceEvent(this.id);
}

part of 'employee_profile_bloc.dart';

sealed class EmployeeProfileEvent {}

class GetEmployeeProfileEvent extends EmployeeProfileEvent {}

class UpdateEmployeeProfileEvent extends EmployeeProfileEvent {
  final int id;
  final File? photoFile;
  final EmployeeProfileRequestModel request;

  UpdateEmployeeProfileEvent({required this.id, required this.request, this.photoFile});
}

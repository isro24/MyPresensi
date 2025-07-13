part of 'employee_permission_bloc.dart';

sealed class EmployeePermissionState {}

class EmployeePermissionInitial extends EmployeePermissionState {}

class EmployeePermissionLoading extends EmployeePermissionState {}

class EmployeePermissionLoaded extends EmployeePermissionState {
  final List<EmployeePermissionData> permissions;

  EmployeePermissionLoaded(this.permissions);
}

class EmployeePermissionSuccess extends EmployeePermissionState {
  final String message;

  EmployeePermissionSuccess(this.message);
}

class EmployeePermissionError extends EmployeePermissionState {
  final String message;

  EmployeePermissionError(this.message);
}
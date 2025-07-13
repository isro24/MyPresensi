part of 'admin_employee_permission_bloc.dart';

sealed class AdminEmployeePermissionState {}

class AdminEmployeePermissionInitial extends AdminEmployeePermissionState {}

class AdminEmployeePermissionLoading extends AdminEmployeePermissionState {}

class AdminEmployeePermissionLoaded extends AdminEmployeePermissionState {
  final List<AdminEmployeePermissionData> permissions;

  AdminEmployeePermissionLoaded(this.permissions);
}

class AdminEmployeePermissionError extends AdminEmployeePermissionState {
  final String message;

  AdminEmployeePermissionError(this.message);
}

class AdminEmployeePermissionActionSuccess extends AdminEmployeePermissionState {
  final String message;

  AdminEmployeePermissionActionSuccess(this.message);
}

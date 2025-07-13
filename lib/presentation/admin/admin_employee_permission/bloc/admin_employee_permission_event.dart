part of 'admin_employee_permission_bloc.dart';

sealed class AdminEmployeePermissionEvent {}

class GetAdminEmployeePermissionsEvent extends AdminEmployeePermissionEvent {}

class UpdateAdminEmployeePermissionStatusEvent extends AdminEmployeePermissionEvent {
  final int id;
  final String status; 

  UpdateAdminEmployeePermissionStatusEvent(this.id, this.status);
}

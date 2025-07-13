part of 'employee_permission_bloc.dart';

sealed class EmployeePermissionEvent {}

class LoadPermissionsEvent extends EmployeePermissionEvent {}

class CreatePermissionEvent extends EmployeePermissionEvent {
  final Map<String, String> fields;
  final File? attachmentFile;

  CreatePermissionEvent({required this.fields, this.attachmentFile});
}

class UpdatePermissionEvent extends EmployeePermissionEvent {
  final int id;
  final Map<String, String> fields;
  final File? attachmentFile;

  UpdatePermissionEvent({
    required this.id,
    required this.fields,
    this.attachmentFile,
  });
}

class DeletePermissionEvent extends EmployeePermissionEvent {
  final int id;

  DeletePermissionEvent(this.id);
}
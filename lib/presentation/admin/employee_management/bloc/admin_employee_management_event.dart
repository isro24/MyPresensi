part of 'admin_employee_management_bloc.dart';

sealed class AdminEmployeeManagementEvent {}

class LoadAllEmployees extends AdminEmployeeManagementEvent {}

class CreateEmployee extends AdminEmployeeManagementEvent {
  final EmployeeManagementRequestModel model;
  CreateEmployee(this.model);
}

class UpdateEmployee extends AdminEmployeeManagementEvent {
  final int id;
  final EmployeeManagementRequestModel model;
  UpdateEmployee({required this.id, required this.model});
}

class DeleteEmployee extends AdminEmployeeManagementEvent {
  final int id;
  DeleteEmployee(this.id);
}

class ConfirmDeleteEmployee extends AdminEmployeeManagementEvent {
  final int id;
  ConfirmDeleteEmployee(this.id);
}


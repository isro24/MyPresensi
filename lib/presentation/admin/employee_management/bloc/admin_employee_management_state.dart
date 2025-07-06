part of 'admin_employee_management_bloc.dart';

sealed class AdminEmployeeManagementState {}

class AdminEmployeeManagementInitial extends AdminEmployeeManagementState {}

class AdminEmployeeManagementLoading extends AdminEmployeeManagementState {}

class AdminEmployeeManagementLoaded extends AdminEmployeeManagementState {
  final List<EmployeeManagementData> employees;
  AdminEmployeeManagementLoaded(this.employees);
}

class EmployeeManagementError extends AdminEmployeeManagementState {
  final String message;
  EmployeeManagementError(this.message);
}

class UpdateEmployeeSuccess extends AdminEmployeeManagementState {
  final String message;
  UpdateEmployeeSuccess(this.message);
}

class CreateEmployeeSuccess extends AdminEmployeeManagementState {
  final String message;
  CreateEmployeeSuccess(this.message);
}

class DeleteEmployeeSuccess extends AdminEmployeeManagementState {
  final String message;
  DeleteEmployeeSuccess(this.message);
}




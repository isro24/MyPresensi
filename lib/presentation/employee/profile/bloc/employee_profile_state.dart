part of 'employee_profile_bloc.dart';

sealed class EmployeeProfileState {}

final class EmployeeProfileInitial extends EmployeeProfileState {}

final class EmployeeProfileLoading extends EmployeeProfileState {}

final class EmployeeProfileUpdating extends EmployeeProfileState {}

final class EmployeeProfileLoaded extends EmployeeProfileState {
  final EmployeeProfileResponseModel profile;

  EmployeeProfileLoaded({required this.profile});
}

final class EmployeeProfileUpdated extends EmployeeProfileState {
  final EmployeeProfileResponseModel profile;

  EmployeeProfileUpdated({required this.profile});
}

final class EmployeeProfileError extends EmployeeProfileState {
  final String message;

  EmployeeProfileError({required this.message});
}

final class EmployeeProfileUpdateError extends EmployeeProfileState {
  final String message;

  EmployeeProfileUpdateError({required this.message});
}
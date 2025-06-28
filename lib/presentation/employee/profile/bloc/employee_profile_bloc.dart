import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/request/employee/employee_profile_request_model.dart';
import 'package:my_presensi/data/models/response/employee/employee_profile_response_model.dart';
import 'package:my_presensi/data/repository/employee/employee_profile_repository.dart';

part 'employee_profile_event.dart';
part 'employee_profile_state.dart';

class EmployeeProfileBloc extends Bloc<EmployeeProfileEvent, EmployeeProfileState> {
  final EmployeeProfileRepository employeeProfileRepository;

  EmployeeProfileBloc({required this.employeeProfileRepository})
      : super(EmployeeProfileInitial()) {
    on<GetEmployeeProfileEvent>(_getEmployeeProfile);
    on<UpdateEmployeeProfileEvent>(_updateEmployeeProfile);
  }

  Future<void> _getEmployeeProfile(
    GetEmployeeProfileEvent event,
    Emitter<EmployeeProfileState> emit,
  ) async {
    emit(EmployeeProfileLoading());

    final result = await employeeProfileRepository.getEmployeeProfile();

    result.fold(
      (error) => emit(EmployeeProfileError(message: error)),
      (profile) => emit(EmployeeProfileLoaded(profile: profile)),
    );
  }

  Future<void> _updateEmployeeProfile(
    UpdateEmployeeProfileEvent event,
    Emitter<EmployeeProfileState> emit,
  ) async {
    emit(EmployeeProfileUpdating());

    final result = await employeeProfileRepository.updateEmployeeProfile(event.id, event.request, event.photoFile);

    result.fold(
      (error) => emit(EmployeeProfileUpdateError(message: error)),
      (profile) => emit(EmployeeProfileUpdated(profile: profile)),
    );
  }
}
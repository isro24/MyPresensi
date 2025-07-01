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
    on<ResetEmployeeProfileStateEvent>(_resetEmployeeProfileState);
    
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
    EmployeeProfileResponseModel? previousProfile;
    if (state is EmployeeProfileLoaded) {
      previousProfile = (state as EmployeeProfileLoaded).profile;
    } else if (state is EmployeeProfileUpdated) {
      previousProfile = (state as EmployeeProfileUpdated).profile;
    }

    emit(EmployeeProfileUpdating());

    final result = await employeeProfileRepository.updateEmployeeProfile(
      event.id,
      event.request,
      event.photoFile,
    );

    result.fold(
      (error) {
        if (previousProfile != null) {
          emit(EmployeeProfileUpdateError(
            message: error,
            previousProfile: previousProfile,
          ));
        } else {
          emit(EmployeeProfileError(message: error));
        }
      },
      (profile) => emit(EmployeeProfileUpdated(profile: profile)),
    );
  }


  Future<void> _resetEmployeeProfileState(
    ResetEmployeeProfileStateEvent event,
    Emitter<EmployeeProfileState> emit,
  ) async {
    final currentState = state;

    if (currentState is EmployeeProfileLoaded) {
      emit(EmployeeProfileLoaded(profile: currentState.profile));
    } else if (currentState is EmployeeProfileUpdated) {
      emit(EmployeeProfileLoaded(profile: currentState.profile));
    } else if (currentState is EmployeeProfileUpdateError) {
      emit(EmployeeProfileLoaded(profile: currentState.previousProfile));
    } else {
      emit(EmployeeProfileInitial());
    }
  }
}
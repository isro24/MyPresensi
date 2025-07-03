import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/request/admin/admin_profile_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_profile_response_model.dart';
import 'package:my_presensi/data/repository/admin/admin_profile_repository.dart';

part 'admin_profile_event.dart';
part 'admin_profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final AdminProfileRepository adminProfileRepository;

  AdminProfileBloc({required this.adminProfileRepository})
      : super(AdminProfileInitial()) {
    on<GetAdminProfileEvent>(_getAdminProfile);
    on<UpdateAdminProfileEvent>(_updateAdminProfile);
    on<ResetAdminProfileStateEvent>(_resetAdminProfileState);
    
  }

  Future<void> _getAdminProfile(
    GetAdminProfileEvent event,
    Emitter<AdminProfileState> emit,
  ) async {
    emit(AdminProfileLoading());

    final result = await adminProfileRepository.getAdminProfile();

    result.fold(
      (error) => emit(AdminProfileError(message: error)),
      (profile) => emit(AdminProfileLoaded(profile: profile)),
    );
  }

  Future<void> _updateAdminProfile(
    UpdateAdminProfileEvent event,
    Emitter<AdminProfileState> emit,
  ) async {
    AdminProfileResponseModel? previousProfile;
    if (state is AdminProfileLoaded) {
      previousProfile = (state as AdminProfileLoaded).profile;
    } else if (state is AdminProfileUpdated) {
      previousProfile = (state as AdminProfileUpdated).profile;
    }

    emit(AdminProfileUpdating());

    final result = await adminProfileRepository.updateAdminProfile(
      event.id,
      event.request,
      event.photoFile,
    );

    result.fold(
      (error) {
        if (previousProfile != null) {
          emit(AdminProfileUpdateError(
            message: error,
            previousProfile: previousProfile,
          ));
        } else {
          emit(AdminProfileError(message: error));
        }
      },
      (profile) => emit(AdminProfileUpdated(profile: profile)),
    );
  }


  Future<void> _resetAdminProfileState(
    ResetAdminProfileStateEvent event,
    Emitter<AdminProfileState> emit,
  ) async {
    final currentState = state;

    if (currentState is AdminProfileLoaded) {
      emit(AdminProfileLoaded(profile: currentState.profile));
    } else if (currentState is AdminProfileUpdated) {
      emit(AdminProfileLoaded(profile: currentState.profile));
    } else if (currentState is AdminProfileUpdateError) {
      emit(AdminProfileLoaded(profile: currentState.previousProfile));
    } else {
      emit(AdminProfileInitial());
    }
  }
}


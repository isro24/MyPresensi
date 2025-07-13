import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/response/employee/employee_permission_response_model.dart';
import 'package:my_presensi/data/repository/employee/employee_permission_repository.dart';

part 'employee_permission_event.dart';
part 'employee_permission_state.dart';

class EmployeePermissionBloc extends Bloc<EmployeePermissionEvent, EmployeePermissionState> {
  final EmployeePermissionRepository repository;

  EmployeePermissionBloc({required this.repository}) : super(EmployeePermissionInitial()) {
    on<LoadPermissionsEvent>(_onLoadPermissions);
    on<CreatePermissionEvent>(_onCreatePermission);
    on<UpdatePermissionEvent>(_onUpdatePermission);
    on<DeletePermissionEvent>(_onDeletePermission);
  }

  Future<void> _onLoadPermissions(
      LoadPermissionsEvent event,
      Emitter<EmployeePermissionState> emit) async {
    emit(EmployeePermissionLoading());
    final result = await repository.getMyPermissions();
    result.fold(
      (error) => emit(EmployeePermissionError(error)),
      (permissions) => emit(EmployeePermissionLoaded(permissions)),
    );
  }

  Future<void> _onCreatePermission(
      CreatePermissionEvent event,
      Emitter<EmployeePermissionState> emit) async {
    emit(EmployeePermissionLoading());
    final result = await repository.createPermission(event.fields, event.attachmentFile);
    result.fold(
      (error) => emit(EmployeePermissionError(error)),
      (message) {
        emit(EmployeePermissionSuccess(message));
        add(LoadPermissionsEvent());
      },
    );
  }

  Future<void> _onUpdatePermission(
      UpdatePermissionEvent event,
      Emitter<EmployeePermissionState> emit) async {
    emit(EmployeePermissionLoading());
    final result = await repository.updatePermission(event.id, event.fields, event.attachmentFile);
    result.fold(
      (error) => emit(EmployeePermissionError(error)),
      (message) {
        emit(EmployeePermissionSuccess(message));
        add(LoadPermissionsEvent());
      },
    );
  }

  Future<void> _onDeletePermission(
      DeletePermissionEvent event,
      Emitter<EmployeePermissionState> emit) async {
    emit(EmployeePermissionLoading());
    final result = await repository.deletePermission(event.id);
    result.fold(
      (error) => emit(EmployeePermissionError(error)),
      (message) {
        emit(EmployeePermissionSuccess(message));
        add(LoadPermissionsEvent());
      },
    );
  }
}
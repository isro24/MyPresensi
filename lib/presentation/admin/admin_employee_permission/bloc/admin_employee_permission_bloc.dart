import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_permission_response_model.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_permission_repository.dart';

part 'admin_employee_permission_event.dart';
part 'admin_employee_permission_state.dart';

class AdminEmployeePermissionBloc extends Bloc<AdminEmployeePermissionEvent, AdminEmployeePermissionState> {
  final AdminEmployeePermissionRepository adminEmployeePermissionRepository;

  AdminEmployeePermissionBloc({
    required this.adminEmployeePermissionRepository,
  }): super(AdminEmployeePermissionInitial()) {
    on<GetAdminEmployeePermissionsEvent>((event, emit) async {
      emit(AdminEmployeePermissionLoading());
      final result = await adminEmployeePermissionRepository.getAll();
      result.fold(
        (error) => emit(AdminEmployeePermissionError(error)),
        (data) => emit(AdminEmployeePermissionLoaded(data)),
      );
    });

    on<UpdateAdminEmployeePermissionStatusEvent>((event, emit) async {
      emit(AdminEmployeePermissionLoading());
      final result = await adminEmployeePermissionRepository.updateStatus(event.id, event.status);
      result.fold(
        (error) => emit(AdminEmployeePermissionError(error)),
        (msg) => emit(AdminEmployeePermissionActionSuccess(msg)),
      );
    });
  }
}


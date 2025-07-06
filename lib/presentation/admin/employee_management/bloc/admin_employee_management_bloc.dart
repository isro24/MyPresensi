import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/request/admin/admin_employee_management_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_management_repository.dart';

part 'admin_employee_management_event.dart';
part 'admin_employee_management_state.dart';

class AdminEmployeeManagementBloc extends Bloc<AdminEmployeeManagementEvent, AdminEmployeeManagementState> {
  final AdminEmployeeManagementRepository adminEmployeeManagementRepository ;

  AdminEmployeeManagementBloc({required this.adminEmployeeManagementRepository}) : super(AdminEmployeeManagementInitial()) {
    on<LoadAllEmployees>(_onLoadAll);
    on<CreateEmployee>(_onCreate);
    on<UpdateEmployee>(_onUpdate);
    on<DeleteEmployee>(_onDelete);
    on<ConfirmDeleteEmployee>(_onConfirmDelete);

  }

  Future<void> _onLoadAll(LoadAllEmployees event, Emitter<AdminEmployeeManagementState> emit) async {
    emit(AdminEmployeeManagementLoading());
    final result = await adminEmployeeManagementRepository.getAllEmployees();
    result.fold(
      (error) => emit(EmployeeManagementError(error)),
      (data) => emit(AdminEmployeeManagementLoaded(data)),
    );
  }

  Future<void> _onCreate(CreateEmployee event, Emitter<AdminEmployeeManagementState> emit) async {
    emit(AdminEmployeeManagementLoading());
    final result = await adminEmployeeManagementRepository.createEmployee(event.model);
    result.fold(
      (error) => emit(EmployeeManagementError(error)),
      (_) {
        emit(CreateEmployeeSuccess("Karyawan berhasil ditambahkan"));
        add(LoadAllEmployees()); // 
      },
    );
  }

  Future<void> _onUpdate(UpdateEmployee event, Emitter<AdminEmployeeManagementState> emit) async {
    emit(AdminEmployeeManagementLoading());
    final result = await adminEmployeeManagementRepository.updateEmployee(event.id, event.model);
    result.fold(
      (error) => emit(EmployeeManagementError(error)),
      (_) {
        emit(UpdateEmployeeSuccess("Karyawan berhasil diperbarui"));
        add(LoadAllEmployees()); 
      },
    );
  }

  Future<void> _onDelete(DeleteEmployee event, Emitter<AdminEmployeeManagementState> emit) async {
    emit(AdminEmployeeManagementLoading());

    final result = await adminEmployeeManagementRepository.deleteEmployee(event.id);

    if (result.isLeft()) {
      final error = result.fold((l) => l, (_) => '');
      emit(EmployeeManagementError(error));
      return;
    }

    emit(DeleteEmployeeSuccess("Karyawan berhasil dihapus"));

    emit(AdminEmployeeManagementLoading());

    final loadResult = await adminEmployeeManagementRepository.getAllEmployees();

    loadResult.fold(
      (error) => emit(EmployeeManagementError(error)),
      (data) => emit(AdminEmployeeManagementLoaded(data)),
    );
  }

  Future<void> _onConfirmDelete(
    ConfirmDeleteEmployee event,
    Emitter<AdminEmployeeManagementState> emit,
  ) async {
    final result = await adminEmployeeManagementRepository.deleteEmployee(event.id);
    result.fold(
      (error) => emit(EmployeeManagementError(error)),
      (_) => add(LoadAllEmployees()),
    );
  }

}

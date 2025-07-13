import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';
import 'package:my_presensi/data/repository/admin/admin_dashbaord_repository.dart';

part 'admin_dashbaord_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final AdminDashboardRepository adminDashboardRepository;

  AdminDashboardBloc({required this.adminDashboardRepository}) : super(AdminDashboardInitial()) {
    on<GetAdminDashboardEvent>((event, emit) async {
      emit(AdminDashboardLoading());

      final Either<String, AdminDashboardResponseModel> result =
          await adminDashboardRepository.getAdminDashboard();

      result.fold(
        (failureMessage) => emit(AdminDashboardError(failureMessage)),
        (data) => emit(AdminDashboardLoaded(data.data!)),
      );
    });
  }
}

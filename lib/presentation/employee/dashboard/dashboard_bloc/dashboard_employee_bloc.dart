import 'package:bloc/bloc.dart';
import 'package:my_presensi/data/models/response/employee/dashboard_response_model.dart';
import 'package:my_presensi/data/repository/dashboard_repository.dart';

part 'dashboard_employee_event.dart';
part 'dashboard_employee_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardBloc({required this.dashboardRepository})
      : super(DashboardInitial()) {
    on<GetDashboardDataEvent>(_getDashboardData);
  }

  Future<void> _getDashboardData(
    GetDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    final result = await dashboardRepository.getDashboardData();

    result.fold(
      (error) => emit(DashboardError(message: error)),
      (dashboard) => emit(DashboardLoaded(dashboard: dashboard)),
    );
  }
}

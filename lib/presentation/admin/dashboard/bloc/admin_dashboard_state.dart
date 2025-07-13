part of 'admin_dashboard_bloc.dart';

sealed class AdminDashboardState {}

class AdminDashboardInitial extends AdminDashboardState {}

class AdminDashboardLoading extends AdminDashboardState {}

class AdminDashboardLoaded extends AdminDashboardState {
  final AdminDashboardData data; 

  AdminDashboardLoaded(this.data);
}

class AdminDashboardError extends AdminDashboardState {
  final String message;

  AdminDashboardError(this.message);
}

part of 'employee_dashboard_bloc.dart';

sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  final DashboardResponseModel dashboard;

  DashboardLoaded({required this.dashboard});
}

final class DashboardError extends DashboardState {
  final String message;

  DashboardError({required this.message});
}
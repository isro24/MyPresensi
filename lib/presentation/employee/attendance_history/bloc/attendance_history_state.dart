part of 'attendance_history_bloc.dart';

sealed class AttendanceHistoryState {}

final class AttendanceHistoryInitial extends AttendanceHistoryState {}

final class AttendanceHistoryLoading extends AttendanceHistoryState {}

final class AttendanceHistoryLoaded extends AttendanceHistoryState {
  final List<Data> history;

  AttendanceHistoryLoaded({required this.history});
}

final class AttendanceHistoryError extends AttendanceHistoryState {
  final String message;

  AttendanceHistoryError({required this.message});
}

class AttendanceHistoryDetailLoaded extends AttendanceHistoryState {
  final Data detail;

  AttendanceHistoryDetailLoaded({required this.detail});
}

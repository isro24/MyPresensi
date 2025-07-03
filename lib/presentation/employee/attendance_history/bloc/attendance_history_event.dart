part of 'attendance_history_bloc.dart';

sealed class AttendanceHistoryEvent {}

class LoadAttendanceHistoryEvent extends AttendanceHistoryEvent {}

class ResetAttendanceHistoryStateEvent extends AttendanceHistoryEvent {}

class LoadAttendanceDetailEvent extends AttendanceHistoryEvent {
  final Data attendance;

  LoadAttendanceDetailEvent({required this.attendance});
}

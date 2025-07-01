part of 'employee_attendance_bloc.dart';

sealed class EmployeeAttendanceEvent {}

class LoadCurrentLocation extends EmployeeAttendanceEvent {}

class PickCameraPhoto extends EmployeeAttendanceEvent {
  final BuildContext context;
  PickCameraPhoto(this.context);
}

class UpdatePickedLocation extends EmployeeAttendanceEvent {
  final double latitude;
  final double longitude;
  final String address;

  UpdatePickedLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class SubmitAttendance extends EmployeeAttendanceEvent {
  final bool isClockIn;
  final String? note;
  final BuildContext context;

  SubmitAttendance({required this.isClockIn, this.note, required this.context});
}

class ShowErrorMessage extends EmployeeAttendanceEvent {
  final String message;
  ShowErrorMessage(this.message);
}


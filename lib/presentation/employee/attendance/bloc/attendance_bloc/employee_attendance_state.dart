part of 'employee_attendance_bloc.dart';

sealed class EmployeeAttendanceState {}

class AttendanceInitial extends EmployeeAttendanceState {}

class AttendanceLoading extends EmployeeAttendanceState {}


class AttendanceLoaded extends EmployeeAttendanceState {
  final File? imageFile;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? errorMessage;
  final bool isSubmitting;

  AttendanceLoaded({
    this.imageFile,
    this.latitude,
    this.longitude,
    this.address,
    this.errorMessage,
    this.isSubmitting = false,
  });

  AttendanceLoaded copyWith({
    File? imageFile,
    double? latitude,
    double? longitude,
    String? address,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return AttendanceLoaded(
      imageFile: imageFile ?? this.imageFile,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class AttendanceSuccess extends EmployeeAttendanceState {
  final EmployeeAttendanceResponseModel data;
  AttendanceSuccess(this.data);
}

class AttendanceFailure extends EmployeeAttendanceState {
  final String message;
  AttendanceFailure(this.message);
}
class AttendanceShowError extends EmployeeAttendanceState {
  final String message;
  AttendanceShowError(this.message);
}

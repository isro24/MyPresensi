import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/data/models/request/employee/employee_attendance_clock_in_request_model.dart';
import 'package:my_presensi/data/models/request/employee/employee_attendance_clock_out_request_model.dart';
import 'package:my_presensi/data/models/response/employee/employee_attendance_response_model.dart';
import 'package:my_presensi/data/repository/employee/employee_attendance_repository.dart';

part 'employee_attendance_event.dart';
part 'employee_attendance_state.dart';

class EmployeeAttendanceBloc extends Bloc<EmployeeAttendanceEvent, EmployeeAttendanceState> {
  final EmployeeAttendanceRepository employeeAttendanceRepository;

  File? _imageFile;

  EmployeeAttendanceBloc({required this.employeeAttendanceRepository}) : super(AttendanceInitial()) {
    on<LoadCurrentLocation>(_onLoadLocation);
    on<PickCameraPhoto>(_onPickCamera);
    on<UpdatePickedLocation>(_onUpdatePickedLocation);
    on<SubmitAttendance>(_onSubmit);
    on<ShowErrorMessage>((event, emit) {});
  }

  Future<void> _onLoadLocation(
    LoadCurrentLocation event, 
    Emitter<EmployeeAttendanceState> emit
  ) async {
    emit(AttendanceLoading());
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        emit(AttendanceFailure("Izin lokasi ditolak"));
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      final placemark = placemarks.first;
      final address = "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}";

      emit(AttendanceLoaded(
        imageFile: _imageFile,
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ));
    } catch (e) {
      emit(AttendanceFailure("Gagal ambil lokasi"));
    }
  }
  Future<void> _onPickCamera(
    PickCameraPhoto event, 
    Emitter<EmployeeAttendanceState> emit
  ) async {
    final file = await event.context.push<File?>('/employee/attendance/camera');
    if (file != null) {
      _imageFile = file;
      if (state is AttendanceLoaded) {
        emit((state as AttendanceLoaded).copyWith(imageFile: _imageFile));
      } else {
        emit(AttendanceLoaded(imageFile: _imageFile));
      }
    }
  }

  void _onUpdatePickedLocation(
    UpdatePickedLocation event,
    Emitter<EmployeeAttendanceState> emit,
  ) {
    if (state is AttendanceLoaded) {
      final current = state as AttendanceLoaded;
      emit(current.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
        address: event.address,
      ));
    }
  }

  Future<void> _onSubmit(
    SubmitAttendance event,
    Emitter<EmployeeAttendanceState> emit,
  ) async {
    if (state is! AttendanceLoaded) {
      emit(AttendanceFailure("Data presensi belum lengkap"));
      return;
    }

    final current = state as AttendanceLoaded;

    if (_imageFile == null || current.latitude == null || current.longitude == null) {
      emit(AttendanceFailure("Foto atau lokasi belum tersedia"));
      return;
    }

    emit(AttendanceLoading());

    try {
      if (event.isClockIn) {
        final req = EmployeeAttendanceClockInRequestModel(
          latitudeClockIn: current.latitude!,
          longitudeClockIn: current.longitude!,
          photoClockIn: _imageFile!.path,
          note: event.note ?? '',
        );
        final result = await employeeAttendanceRepository.clockIn(req);
        result.fold(
          (error) {
            if (state is AttendanceLoaded) {
              final current = state as AttendanceLoaded;
              emit(current.copyWith(errorMessage: error));
            } else {
              emit(AttendanceFailure(error));
            }
          },

          (response) {
            emit(AttendanceSuccess(response));
            _imageFile = null; // reset foto
            emit(AttendanceInitial());
          },
        );
      } else {
        final req = EmployeeAttendanceClockOutRequestModel(
          latitudeClockOut: current.latitude!,
          longitudeClockOut: current.longitude!,
          photoClockOut: _imageFile!.path,
        );
        final result = await employeeAttendanceRepository.clockOut(req);
        result.fold(
          (error) => emit(AttendanceFailure(error)),
          (response) {
            emit(AttendanceSuccess(response));
            _imageFile = null; // reset foto
            emit(AttendanceInitial());
          },
        );
      }
    } catch (e) {
      emit(AttendanceFailure("Gagal submit presensi"));
    }
  }
}

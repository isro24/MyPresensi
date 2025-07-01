import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/request/employee/employee_attendance_clock_in_request_model.dart';
import 'package:my_presensi/data/models/request/employee/employee_attendance_clock_out_request_model.dart';
import 'package:my_presensi/data/models/response/employee/employee_attendance_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class EmployeeAttendanceRepository {
  final ServiceHttpClient _serviceHttpClient;

  EmployeeAttendanceRepository(this._serviceHttpClient);

  Future<Either<String, EmployeeAttendanceResponseModel>> clockIn(
      EmployeeAttendanceClockInRequestModel requestModel) async {
    try {
      final response = await _serviceHttpClient.postMultipartWithToken(
        endPoint: "employee/attendance/clock-in",
        fields: {
          'latitude_clock_in': requestModel.latitudeClockIn.toString(),
          'longitude_clock_in': requestModel.longitudeClockIn.toString(),
          'note': requestModel.note ?? '',
        },
        imageFile: File(requestModel.photoClockIn!),
        imageFieldName: 'photo_clock_in',
      );


      log("Clock In status: ${response.statusCode}");
      log("Clock In body: ${response.body}");

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final attendanceResponse = EmployeeAttendanceResponseModel.fromJson(jsonResponse);
        return Right(attendanceResponse);
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error on clock in');
      }
    } catch (e) {
      return Left("Failed to clock in: $e");
    }
  }

  Future<Either<String, EmployeeAttendanceResponseModel>> clockOut(
      EmployeeAttendanceClockOutRequestModel requestModel) async {
    try {
      final response = await _serviceHttpClient.postMultipartWithToken(
        endPoint: "employee/attendance/clock-out",
        fields: {
          'latitude_clock_out': requestModel.latitudeClockOut.toString(),
          'longitude_clock_out': requestModel.longitudeClockOut.toString(),
        },
        imageFile: File(requestModel.photoClockOut!),
        imageFieldName: 'photo_clock_out',
      );

      log("Clock Out status: ${response.statusCode}");
      log("Clock Out body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final attendanceResponse = EmployeeAttendanceResponseModel.fromJson(jsonResponse);
        return Right(attendanceResponse);
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error on clock out');
      }
    } catch (e) {
      return Left("Failed to clock out: $e");
    }
  }

  Future<Either<String, EmployeeAttendanceResponseModel>> getLatestAttendance() async {
    try {
      final response = await _serviceHttpClient.get("employee/attendance");

      log("Get Attendance status: ${response.statusCode}");
      log("Get Attendance body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final attendanceResponse = EmployeeAttendanceResponseModel.fromJson(jsonResponse);
        return Right(attendanceResponse);
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error while fetching attendance data');
      }
    } catch (e) {
      return Left("Failed to fetch attendance data: $e");
    }
  }
}

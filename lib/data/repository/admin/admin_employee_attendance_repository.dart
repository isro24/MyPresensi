import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_attendance_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AdminEmployeeAttendanceRepository {
  final ServiceHttpClient _serviceHttpClient;

  AdminEmployeeAttendanceRepository(this._serviceHttpClient);

Future<Either<String, List<EmployeeAttendanceData>>> getAllEmployeeAttendance() async {
  try {
    final response = await _serviceHttpClient.get("admin/attendance");
    log("Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<EmployeeAttendanceData> attendances =
          (jsonResponse["data"] as List)
              .map((e) => EmployeeAttendanceData.fromJson(e))
              .toList();

      await Future.wait(attendances.map((att) async {
        if (att.photoClockIn.isNotEmpty) {
          att.photoClockInBytes = await _serviceHttpClient.getPrivateImage(att.photoClockIn);
        }
        if (att.photoClockOut.isNotEmpty) {
          att.photoClockOutBytes = await _serviceHttpClient.getPrivateImage(att.photoClockOut);
        }
      }));

      return Right(attendances);
    } else {
      final errorJson = json.decode(response.body);
      return Left(errorJson['message'] ?? 'Unknown error while fetching attendance');
    }
  } catch (e) {
    return Left("Failed to fetch attendance list: $e");
  }
}


  Future<Either<String, String>> deleteAttendance(int id) async {
    try {
      final response = await _serviceHttpClient.deleteWithToken("admin/attendance/$id");
      log("Delete Attendance Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message'] ?? 'Attendance deleted successfully');
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error while deleting attendance');
      }
    } catch (e) {
      return Left("Failed to delete attendance: $e");
    }
  }
}
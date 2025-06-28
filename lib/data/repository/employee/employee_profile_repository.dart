import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/request/employee/employee_profile_request_model.dart';
import 'package:my_presensi/data/models/response/employee/employee_profile_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class EmployeeProfileRepository {
  final ServiceHttpClient _serviceHttpClient;

  EmployeeProfileRepository(this._serviceHttpClient);

  // Fetches the employee profile data from the server.
  Future<Either<String, EmployeeProfileResponseModel>> getEmployeeProfile() async {
    try {
      final response = await _serviceHttpClient.get("employee/profile");

      log("Profile status: ${response.statusCode}");
      log("Profile body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final employeeProfileResponse = EmployeeProfileResponseModel.fromJson(jsonResponse);
        print("Profile Response: $employeeProfileResponse");
        return Right(employeeProfileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while fetching employee profile: $e");
    }
  }

  // Updates the employee profile data on the server.
  Future<Either<String, EmployeeProfileResponseModel>> updateEmployeeProfile(
    int id,
    EmployeeProfileRequestModel requestModel,
    File? photoFile,
  ) async {
    try {
      final response = await _serviceHttpClient.putWithTokenMultipart(
        "employee/profile/$id",
        {
          'phone': requestModel.phone ?? '',
          'address': requestModel.address ?? '',
        },
        photoFile,
      );

      log("Update Profile status: ${response.statusCode}");
      log("Update Profile body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final employeeProfileResponse = EmployeeProfileResponseModel.fromJson(jsonResponse);
        return Right(employeeProfileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while updating employee profile: $e");
    }
  }

}

      
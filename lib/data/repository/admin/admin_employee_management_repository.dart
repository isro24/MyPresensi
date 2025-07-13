import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/request/admin/admin_employee_management_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AdminEmployeeManagementRepository {
  final ServiceHttpClient _serviceHttpClient;

  AdminEmployeeManagementRepository(this._serviceHttpClient);

  Future<Either<String, List<EmployeeManagementData>>> getAllEmployees() async {
    try {
      final response = await _serviceHttpClient.get("admin/employee");
      log("Get All Employees Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<EmployeeManagementData> employees =
            (jsonResponse["data"] as List).map((e) => EmployeeManagementData.fromJson(e)).toList();
        return Right(employees);
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error while fetching employees');
      }
    } catch (e) {
      return Left("Failed to fetch employee list: $e");
    }
  }

  Future<Either<String, EmployeeManagementResponseModel>> createEmployee(
    EmployeeManagementRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postMultipartWithToken(
        endPoint: "admin/employee",
        fields: requestModel.toMap().map((key, value) => MapEntry(key, value ?? '')),
        imageFile: requestModel.photo != null ? File(requestModel.photo!) : File(''),
        imageFieldName: 'photo',
      );

      log("Create Employee Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final model = EmployeeManagementResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error while creating employee');
      }
    } catch (e) {
      return Left("Failed to create employee: $e");
    }
  }

  Future<Either<String, EmployeeManagementResponseModel>> updateEmployee(
    int id,
    EmployeeManagementRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.putWithTokenMultipart(
        "admin/employee/$id",
        requestModel.toMap().map((key, value) => MapEntry(key, value ?? '')),
        requestModel.photo != null && requestModel.photo!.isNotEmpty
            ? File(requestModel.photo!)
            : null,
      );

      log("Update Employee Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final model = EmployeeManagementResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error while updating employee');
      }
    } catch (e) {
      return Left("Failed to update employee: $e");
    }
  }

  Future<Either<String, String>> deleteEmployee(int id) async {
    try {
      final response = await _serviceHttpClient.deleteWithToken("admin/employee/$id");
      log("Delete Employee Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message'] ?? 'Employee deleted successfully');
      } else {
        final errorJson = json.decode(response.body);
        return Left(errorJson['message'] ?? 'Unknown error while deleting employee');
      }
    } catch (e) {
      return Left("Failed to delete employee: $e");
    }
  }
}

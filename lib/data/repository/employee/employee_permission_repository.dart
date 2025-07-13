import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/response/employee/employee_permission_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class EmployeePermissionRepository {
  final ServiceHttpClient _httpClient;

  EmployeePermissionRepository(this._httpClient);

  // GET all permissions (employeeIndex)
  Future<Either<String, List<EmployeePermissionData>>> getMyPermissions() async {
    try {
      final response = await _httpClient.get("employee/permission");
      log("Employee Get Permissions Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<EmployeePermissionData> permissions = (jsonResponse["data"] as List)
            .map((e) => EmployeePermissionData.fromMap(e))
            .toList();
        return Right(permissions);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Unknown error while fetching permissions');
      }
    } catch (e) {
      return Left("Failed to fetch permission list: $e");
    }
  }

  // CREATE permission
  Future<Either<String, String>> createPermission(Map<String, String> fields, File? attachmentFile) async {
    try {
      final response = await _httpClient.postMultipartWithToken(
        endPoint: "employee/permission",
        fields: fields,
        imageFile: attachmentFile!,
        imageFieldName: "attachment",
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message']);
      } else {
        final error = json.decode(response.body);
        return Left(error['message']);
      }
    } catch (e) {
      return Left("Failed to create permission: $e");
    }
  }

  // UPDATE permission
  Future<Either<String, String>> updatePermission(int id, Map<String, String> fields, File? attachmentFile) async {
    try {
      final response = await _httpClient.putWithTokenMultipart(
        "employee/permission/$id",
        fields,
        attachmentFile,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message']);
      } else {
        final error = json.decode(response.body);
        return Left(error['message']);
      }
    } catch (e) {
      return Left("Failed to update permission: $e");
    }
  }

  // DELETE permission
  Future<Either<String, String>> deletePermission(int id) async {
    try {
      final response = await _httpClient.deleteWithToken("employee/permission/$id");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message']);
      } else {
        final error = json.decode(response.body);
        return Left(error['message']);
      }
    } catch (e) {
      return Left("Failed to delete permission: $e");
    }
  }
}

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_permission_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AdminEmployeePermissionRepository {
  final ServiceHttpClient _httpClient;

  AdminEmployeePermissionRepository(this._httpClient);

  // GET all permissions
  Future<Either<String, List<AdminEmployeePermissionData>>> getAll() async {
    try {
      final response = await _httpClient.get("admin/permission");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final List<AdminEmployeePermissionData> permissions =
            (jsonResponse["data"] as List)
                .map((e) => AdminEmployeePermissionData.fromMap(e))
                .toList();

        return Right(permissions);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Unknown error while fetching permissions');
      }
    } catch (e) {
      return Left("Failed to fetch admin permission list: $e");
    }
  }

  // Update permission status
  Future<Either<String, String>> updateStatus(int id, String status) async {
    try {
      final response = await _httpClient.patchWithToken("admin/permission/$id/status", {
        'status': status,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message']);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Unknown error');
      }
    } catch (e) {
      return Left('Failed to update status: $e');
    }
  }


}

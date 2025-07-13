import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AdminDashboardRepository {
  final ServiceHttpClient _httpClient;

  AdminDashboardRepository(this._httpClient);

  Future<Either<String, AdminDashboardResponseModel>> getAdminDashboard() async {
    try {
      final response = await _httpClient.get('admin/dashboard');

      log("Admin Dashboard status: ${response.statusCode}");
      log("Admin Dashboard body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final dashboardResponse = AdminDashboardResponseModel.fromMap(jsonData);
        return Right(dashboardResponse);
      } else {
        final errorMessage = jsonDecode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while fetching admin dashboard: $e");
    }
  }
}

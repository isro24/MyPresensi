import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/response/employee/employee_dashboard_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class DashboardRepository {
  final ServiceHttpClient _serviceHttpClient;

  DashboardRepository(this._serviceHttpClient);

  Future<Either<String, DashboardResponseModel>> getDashboardData() async {
    try {
      final response = await _serviceHttpClient.get("employee/dashboard");

      log("Dashboard status: ${response.statusCode}");
      log("Dashboard body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final dashboardResponse = DashboardResponseModel.fromJson(jsonResponse);
        print("Profile Response: $dashboardResponse");
        return Right(dashboardResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while fetching dashboard data: $e");
    }
  }
}

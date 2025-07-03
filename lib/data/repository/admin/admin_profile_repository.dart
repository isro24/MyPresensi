import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/request/admin/admin_profile_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_profile_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AdminProfileRepository {
  final ServiceHttpClient _serviceHttpClient;

  AdminProfileRepository(this._serviceHttpClient);

  // Fetches the admin profile data from the server.
  Future<Either<String, AdminProfileResponseModel>> getAdminProfile() async {
    try {
      final response = await _serviceHttpClient.get("admin/profile");

      log("Profile status: ${response.statusCode}");
      log("Profile body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final adminProfileResponse = AdminProfileResponseModel.fromJson(jsonResponse);
        log("Profile Response: $adminProfileResponse");
        return Right(adminProfileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while fetching admin profile: $e");
    }
  }

  // Updates the admin profile data on the server.
  Future<Either<String, AdminProfileResponseModel>> updateAdminProfile(
    int id,
    AdminProfileRequestModel requestModel,
    File? photoFile,
  ) async {
    try {
      final response = await _serviceHttpClient.putWithTokenMultipart(
        "admin/profile/$id",
        {
          '_method': 'PUT',
          'name': requestModel.name ?? '',
          'email': requestModel.email ?? '',
          'position': requestModel.position ?? '',
          'phone': requestModel.phone ?? '',
        },
        photoFile,
      );

      log("Update Profile status: ${response.statusCode}");
      log("Update Profile body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final adminProfileResponse = AdminProfileResponseModel.fromJson(jsonResponse);
        return Right(adminProfileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while updating admin profile: $e");
    }
  }

}

      
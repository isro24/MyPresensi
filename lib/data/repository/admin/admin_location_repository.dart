import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:my_presensi/data/models/request/admin/admin_location_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_location_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AdminLocationRepository {
  final ServiceHttpClient _httpClient;

  AdminLocationRepository(this._httpClient);

  // GET all locations
  Future<Either<String, List<LocationData>>> getAllLocations() async {
    try {
      final response = await _httpClient.get("admin/location");
      log("Get All Locations Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<LocationData> locations = (jsonResponse["data"] as List)
            .map((e) => LocationData.fromMap(e))
            .toList();
        return Right(locations);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Unknown error while fetching locations');
      }
    } catch (e) {
      return Left("Failed to fetch location list: $e");
    }
  }

  // CREATE location
  Future<Either<String, String>> createLocation(AdminLocationRequestModel request) async {
    try {
      final response = await _httpClient.postWithToken(
        "admin/location",
        request.toMap(),
      );
      log("Create Location Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse["message"] ?? "Location created successfully");
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? "Failed to create location");
      }
    } catch (e) {
      return Left("Error while creating location: $e");
    }
  }

  // UPDATE location
  Future<Either<String, String>> updateLocation(int id, AdminLocationRequestModel request) async {
    try {
      final response = await _httpClient.putWithToken(
        "admin/location/$id",
        request.toMap(),
      );
      log("Update Location Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse["message"] ?? "Location updated successfully");
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? "Failed to update location");
      }
    } catch (e) {
      return Left("Error while updating location: $e");
    }
  }

  // DELETE location
  Future<Either<String, String>> deleteLocation(int id) async {
    try {
      final response = await _httpClient.deleteWithToken("admin/location/$id");
      log("Delete Location Status: ${response.statusCode}");
      log("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(jsonResponse['message'] ?? 'Location deleted successfully');
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Failed to delete location');
      }
    } catch (e) {
      return Left("Error while deleting location: $e");
    }
  }
}

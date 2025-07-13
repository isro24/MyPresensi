import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_presensi/data/models/request/auth/forgot_password_request_model.dart';
import 'package:my_presensi/data/models/request/auth/login_request_model.dart';
import 'package:my_presensi/data/models/request/auth/reset_password_request_model.dart';
import 'package:my_presensi/data/models/response/auth/login_response_model.dart';
import 'package:my_presensi/service/service_http_client.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'login',
        requestModel.toMap(),
      );

      log(response.body);
      
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromMap(jsonResponse);
        await secureStorage.write(
          key: 'token',
          value: loginResponse.data!.token,
        );
        await secureStorage.write(
          key: 'userRole',
          value: loginResponse.data!.role,
        );
        return Right(loginResponse);
      } else {
        return Left(jsonResponse['message'] ?? 'Login failed');
      }
    } catch (e) {
      return left('An error occured while logging in.');
    }
  }
  
  Future<bool> me() async {
    try {
      final response = await _serviceHttpClient.get(
        'me'
      );
      log(response.body);
      return response.statusCode == 200;
    } catch (e) {
      log('Error in me(): $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _serviceHttpClient.logoutWithToken();
      print('Logout API berhasil');
    } catch (e) {
      log('Error during logout: $e');
    }
    await secureStorage.delete(key: 'token');
    await secureStorage.delete(key: 'userRole');
  }

  // Forgot Password
  Future<Either<String, Map<String, String>>> forgotPassword(
  ForgotPasswordRequestModel model,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        'forgot-password',
        model.toMap(),
      );
      final jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        final data = jsonData['data'];
        return Right({
          'email': data['email'],
          'token': data['token'],
          'message': jsonData['message']
        });
      } else {
        return Left(jsonData['message'] ?? 'Gagal mengirim token reset');
      }
    } catch (e) {
      return Left('Error sending reset token: $e');
    }
  }


  // Reset Password
  Future<Either<String, String>> resetPassword(
    ResetPasswordRequestModel model) async {
    try {
      final response = await _serviceHttpClient.post(
        'reset-password',
        model.toMap(),
      );
      final jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        return Right(jsonData['message'] ?? 'Reset password berhasil');
      } else {
        return Left(jsonData['message'] ?? 'Reset password gagal');
      }
    } catch (e) {
      return Left('Error resetting password: $e');
    }
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';


class ServiceHttpClient {
  final String baseUrl = 'http://192.168.1.11:8000/api/';
  final secureStorage = FlutterSecureStorage();

  //Post Data
  Future<http.Response> post(String endPoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endPoint');
    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    }catch(e){
      throw Exception('Error in post request: $e');
    }
  }

  //Post Data with Token
  Future<http.Response> postWithToken(
    String endPoint, 
    Map<String, dynamic> body
    ) async {
      final url = Uri.parse('$baseUrl$endPoint');
      final token = await secureStorage.read(key: 'token'); 
      try{
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );
        return response;
      }catch(e){
        throw Exception('Error in post request: $e');
      }
  }

  //Get Data
  Future<http.Response> get(String endPoint) async {
    final token = await secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl$endPoint');
    try{
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return response;
    }catch(e){
      throw Exception('Error in get request: $e');
    }
  }

  //Update Data with Token
  Future<http.Response> putWithToken(
    String endPoint, 
    Map<String, dynamic> body
  ) async {
    final url = Uri.parse('$baseUrl$endPoint');
    final token = await secureStorage.read(key: 'token');
    try{
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      return response;
    }catch(e){
      throw Exception('Error in put request: $e');
    }
  }

  //Delete Data with Token
  Future<http.Response> deleteWithToken(String endPoint) async {
    final url = Uri.parse('$baseUrl$endPoint');
    final token = await secureStorage.read(key: 'token');
    try{
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    }catch(e){
      throw Exception('Error in delete request: $e');
    }
  }

  //Logout with Token
  Future<void> logoutWithToken() async {
    final token = await secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl/logout');
    try {
      await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      throw Exception('Error in logout request: $e');
    }
  }

  // Post Data with Token and Multipart for photo
  Future<http.Response> postMultipartWithToken({
    required String endPoint,
    required Map<String, String> fields,
    required File imageFile,
    required String imageFieldName,
  }) async {
    final token = await secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl$endPoint');

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(fields);

    request.files.add(
      await http.MultipartFile.fromPath(
        imageFieldName,
        imageFile.path,
        contentType: MediaType('image', lookupMimeType(imageFile.path) ?? 'jpeg'),
      ),
    );

    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }


  //Put Data with Token and Multipart for Photo
  Future<http.Response> putWithTokenMultipart(
    String endPoint,
    Map<String, String> fields, 
    File? photo, 
  ) async {
    final token = await secureStorage.read(key: 'token');
    final url = Uri.parse('$baseUrl$endPoint');

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..fields['_method'] = 'PUT' 
      ..fields.addAll(fields);

    if (photo != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          photo.path,
          contentType: MediaType('image', lookupMimeType(photo.path) ?? 'jpeg'),
        ),
      );
    }

    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }
}
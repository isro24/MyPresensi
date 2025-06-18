import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
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
}
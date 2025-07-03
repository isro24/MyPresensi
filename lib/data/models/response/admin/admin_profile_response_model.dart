import 'dart:convert';

class AdminProfileResponseModel {
  String message;
  int status;
  AdminProfileData data;

  AdminProfileResponseModel({
    required this.message,
    required this.status,
    required this.data,
  });

  AdminProfileResponseModel copyWith({
    String? message,
    int? status,
    AdminProfileData? data,
  }) =>
      AdminProfileResponseModel(
        message: message ?? this.message,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory AdminProfileResponseModel.fromRawJson(String str) =>
      AdminProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      AdminProfileResponseModel(
        message: json["message"],
        status: json["status_code"], 
        data: AdminProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": status,
        "data": data.toJson(),
      };
}

class AdminProfileData {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String position;
  final String phone;
  final String photo;

  AdminProfileData({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.position,
    required this.phone,
    required this.photo,
  });

  AdminProfileData copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? nip,
    String? position,
    String? department,
    String? gender,
    String? phone,
    String? address,
    String? photo,
  }) =>
      AdminProfileData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        position: position ?? this.position,
        phone: phone ?? this.phone,
        photo: photo ?? this.photo,
      );

  factory AdminProfileData.fromRawJson(String str) => AdminProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminProfileData.fromJson(Map<String, dynamic> json) => AdminProfileData(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        position: json["position"] ?? '',
        phone: json["phone"] ?? '',
        photo: json["photo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "position": position,
        "phone": phone,
        "photo": photo,
      };
}

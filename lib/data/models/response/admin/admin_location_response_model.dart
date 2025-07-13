import 'dart:convert';

class AdminLocationResponseModel {
  final String? message;
  final int? statusCode;
  final List<LocationData>? locations;

  AdminLocationResponseModel({
    this.message,
    this.statusCode,
    this.locations,
  });

  factory AdminLocationResponseModel.fromJson(String str) =>
      AdminLocationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminLocationResponseModel.fromMap(Map<String, dynamic> json) =>
      AdminLocationResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        locations: json["data"] == null
            ? []
            : List<LocationData>.from(
                json["data"].map((x) => LocationData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "data": locations?.map((x) => x.toMap()).toList(),
      };
}

class LocationData {
  final int? id;
  final int? adminId;
  final String? name;
  final String? latitude;
  final String? longitude;
  final String? radius;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LocationData({
    this.id,
    this.adminId,
    this.name,
    this.latitude,
    this.longitude,
    this.radius,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationData.fromJson(String str) =>
      LocationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationData.fromMap(Map<String, dynamic> json) => LocationData(
        id: json["id"],
        adminId: json["admin_id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "admin_id": adminId,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

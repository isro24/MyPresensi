import 'dart:convert';

class AdminLocationRequestModel {
    final String? name;
    final int? latitude;
    final int? longitude;
    final int? radius;

    AdminLocationRequestModel({
        this.name,
        this.latitude,
        this.longitude,
        this.radius,
    });

    factory AdminLocationRequestModel.fromJson(String str) => AdminLocationRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminLocationRequestModel.fromMap(Map<String, dynamic> json) => AdminLocationRequestModel(
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
    };
}

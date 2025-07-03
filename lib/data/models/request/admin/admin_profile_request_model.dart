import 'dart:convert';

class AdminProfileRequestModel {
    final String? name;
    final String? email;
    final String? position;
    final String? phone;
    final String? photo;

    AdminProfileRequestModel({
        this.name,
        this.email,
        this.position,
        this.phone,
        this.photo,
    });

    factory AdminProfileRequestModel.fromJson(String str) => AdminProfileRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminProfileRequestModel.fromMap(Map<String, dynamic> json) => AdminProfileRequestModel(
        name: json["name"],
        email: json["email"],
        position: json["position"],
        phone: json["phone"],
        photo: json["photo"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "position": position,
        "phone": phone,
        "photo": photo,
    };
}

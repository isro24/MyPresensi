import 'dart:convert';

class EmployeeProfileRequestModel {
    final String? phone;
    final String? address;
    final String? photo;

    EmployeeProfileRequestModel({
        this.phone,
        this.address,
        this.photo,
    });

    factory EmployeeProfileRequestModel.fromJson(String str) => EmployeeProfileRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmployeeProfileRequestModel.fromMap(Map<String, dynamic> json) => EmployeeProfileRequestModel(
        phone: json["phone"],
        address: json["address"],
        photo: json["photo"],
    );

    Map<String, dynamic> toMap() => {
        "phone": phone,
        "address": address,
        "photo": photo,
    };
}

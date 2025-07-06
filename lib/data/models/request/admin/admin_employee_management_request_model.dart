import 'dart:convert';

class EmployeeManagementRequestModel {
    final String? name;
    final String? email;
    final String? password;
    final String? nip;
    final String? position;
    final String? department;
    final String? gender;
    final String? phone;
    final String? address;
    final String? photo;

    EmployeeManagementRequestModel({
        this.name,
        this.email,
        this.password,
        this.nip,
        this.position,
        this.department,
        this.gender,
        this.phone,
        this.address,
        this.photo,
    });

    factory EmployeeManagementRequestModel.fromJson(String str) => EmployeeManagementRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmployeeManagementRequestModel.fromMap(Map<String, dynamic> json) => EmployeeManagementRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        nip: json["nip"],
        position: json["position"],
        department: json["department"],
        gender: json["gender"],
        phone: json["phone"],
        address: json["address"],
        photo: json["photo"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "nip": nip,
        "position": position,
        "department": department,
        "gender": gender,
        "phone": phone,
        "address": address,
        "photo": photo,
    };
}

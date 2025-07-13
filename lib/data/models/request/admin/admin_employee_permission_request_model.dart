import 'dart:convert';

class AdminEmployeePermissionRequestModel {
    final String? status;

    AdminEmployeePermissionRequestModel({
        this.status,
    });

    factory AdminEmployeePermissionRequestModel.fromJson(String str) => AdminEmployeePermissionRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminEmployeePermissionRequestModel.fromMap(Map<String, dynamic> json) => AdminEmployeePermissionRequestModel(
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
    };
}
